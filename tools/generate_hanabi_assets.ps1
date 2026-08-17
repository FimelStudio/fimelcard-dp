param(
    [string]$ResourcePack = 'D:\PCL2\MinecraftPcl\versions\26.2-Fabric_0.19.3\resourcepacks\fimelcard-rp'
)

# 使用已经去除色键背景的母版，确定性生成花火的全部牌面与提示状态。
# 母版只决定富士山背景、边框和牌背；数字、烟花、颜色与输出尺寸均由本脚本固定。

Add-Type -AssemblyName System.Drawing

$sourceDir = Join-Path $ResourcePack '.source\hanabi'
$frontSource = Join-Path $sourceDir 'front_master_alpha.png'
$backSource = Join-Path $sourceDir 'back_master_alpha.png'
$itemDir = Join-Path $ResourcePack 'assets\card\textures\item\hanabi'

if (-not (Test-Path -LiteralPath $frontSource)) {
    throw "缺少正面母版：$frontSource"
}
if (-not (Test-Path -LiteralPath $backSource)) {
    throw "缺少牌背母版：$backSource"
}

New-Item -ItemType Directory -Path $itemDir -Force | Out-Null

function Get-AlphaBounds {
    param([System.Drawing.Bitmap]$Bitmap)

    $left = $Bitmap.Width
    $top = $Bitmap.Height
    $right = -1
    $bottom = -1

    for ($y = 0; $y -lt $Bitmap.Height; $y++) {
        for ($x = 0; $x -lt $Bitmap.Width; $x++) {
            if ($Bitmap.GetPixel($x, $y).A -gt 8) {
                if ($x -lt $left) { $left = $x }
                if ($x -gt $right) { $right = $x }
                if ($y -lt $top) { $top = $y }
                if ($y -gt $bottom) { $bottom = $y }
            }
        }
    }

    if ($right -lt $left -or $bottom -lt $top) {
        throw '母版没有可见像素。'
    }

    return [System.Drawing.Rectangle]::new(
        $left,
        $top,
        $right - $left + 1,
        $bottom - $top + 1
    )
}

function Resize-Nearest {
    param(
        [System.Drawing.Bitmap]$Source,
        [int]$Width,
        [int]$Height,
        [System.Drawing.Rectangle]$SourceRectangle = [System.Drawing.Rectangle]::new(0, 0, $Source.Width, $Source.Height)
    )

    $output = [System.Drawing.Bitmap]::new(
        $Width,
        $Height,
        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    )
    $graphics = [System.Drawing.Graphics]::FromImage($output)
    try {
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighSpeed
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
        $graphics.DrawImage(
            $Source,
            [System.Drawing.Rectangle]::new(0, 0, $Width, $Height),
            $SourceRectangle,
            [System.Drawing.GraphicsUnit]::Pixel
        )
    }
    finally {
        $graphics.Dispose()
    }
    return $output
}

function Copy-Bitmap {
    param([System.Drawing.Bitmap]$Source)

    $copy = [System.Drawing.Bitmap]::new(
        $Source.Width,
        $Source.Height,
        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    )
    $graphics = [System.Drawing.Graphics]::FromImage($copy)
    try {
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $graphics.DrawImageUnscaled($Source, 0, 0)
    }
    finally {
        $graphics.Dispose()
    }
    return $copy
}

$digitPatterns = @{
    1 = @(
        '00100',
        '01100',
        '00100',
        '00100',
        '00100',
        '00100',
        '01110'
    )
    2 = @(
        '01110',
        '10001',
        '00001',
        '00010',
        '00100',
        '01000',
        '11111'
    )
    3 = @(
        '11110',
        '00001',
        '00001',
        '01110',
        '00001',
        '00001',
        '11110'
    )
    4 = @(
        '00010',
        '00110',
        '01010',
        '10010',
        '11111',
        '00010',
        '00010'
    )
    5 = @(
        '11111',
        '10000',
        '10000',
        '11110',
        '00001',
        '00001',
        '11110'
    )
}

function Draw-Digit {
    param(
        [System.Drawing.Graphics]$Graphics,
        [int]$Digit,
        [int]$X,
        [int]$Y,
        [int]$Scale,
        [System.Drawing.Color]$Color,
        [bool]$Rotate180 = $false
    )

    $pattern = $digitPatterns[$Digit]
    $brush = [System.Drawing.SolidBrush]::new($Color)
    $shadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(190, 15, 24, 38))
    try {
        for ($row = 0; $row -lt 7; $row++) {
            for ($column = 0; $column -lt 5; $column++) {
                if ($pattern[$row][$column] -ne '1') { continue }

                if ($Rotate180) {
                    $drawColumn = 4 - $column
                    $drawRow = 6 - $row
                }
                else {
                    $drawColumn = $column
                    $drawRow = $row
                }

                $pixelX = $X + $drawColumn * $Scale
                $pixelY = $Y + $drawRow * $Scale
                $Graphics.FillRectangle($shadow, $pixelX + 1, $pixelY + 1, $Scale, $Scale)
                $Graphics.FillRectangle($brush, $pixelX, $pixelY, $Scale, $Scale)
            }
        }
    }
    finally {
        $brush.Dispose()
        $shadow.Dispose()
    }
}

function Draw-Firework {
    param(
        [System.Drawing.Graphics]$Graphics,
        [int]$CenterX,
        [int]$CenterY,
        [System.Drawing.Color]$Color,
        [int]$Seed,
        [int]$Scale = 1
    )

    $rayPen = [System.Drawing.Pen]::new($Color, $Scale)
    $highlight = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 248, 218))
    $spark = [System.Drawing.SolidBrush]::new($Color)
    try {
        $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
        for ($index = 0; $index -lt 16; $index++) {
            $angle = ($index * 22.5 + ($Seed % 7)) * [Math]::PI / 180.0
            $inner = (3 + (($index + $Seed) % 2)) * $Scale
            $outer = (8 + (($index * 3 + $Seed) % 4)) * $Scale
            $x1 = [int][Math]::Round($CenterX + [Math]::Cos($angle) * $inner)
            $y1 = [int][Math]::Round($CenterY + [Math]::Sin($angle) * $inner)
            $x2 = [int][Math]::Round($CenterX + [Math]::Cos($angle) * $outer)
            $y2 = [int][Math]::Round($CenterY + [Math]::Sin($angle) * $outer)
            $Graphics.DrawLine($rayPen, $x1, $y1, $x2, $y2)

            if (($index + $Seed) % 3 -eq 0) {
                $Graphics.FillRectangle($spark, $x2, $y2, $Scale, $Scale)
            }
        }
        $Graphics.FillRectangle(
            $highlight,
            $CenterX - $Scale,
            $CenterY - $Scale,
            3 * $Scale,
            3 * $Scale
        )
    }
    finally {
        $rayPen.Dispose()
        $highlight.Dispose()
        $spark.Dispose()
    }
}

function Save-CardTexture {
    param(
        [System.Drawing.Bitmap]$Card,
        [string]$Name
    )

    # 物品纹理保留256×256画布，牌面本体为160×256。
    # 字体直接引用这张物品纹理，并用负间距抵消左右透明区，避免保存重复图片。
    $itemTexture = [System.Drawing.Bitmap]::new(
        256,
        256,
        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    )
    try {
        $graphics = [System.Drawing.Graphics]::FromImage($itemTexture)
        try {
            $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $graphics.DrawImageUnscaled($Card, 48, 0)
        }
        finally {
            $graphics.Dispose()
        }
        $itemTexture.Save(
            (Join-Path $itemDir "$Name.png"),
            [System.Drawing.Imaging.ImageFormat]::Png
        )
    }
    finally {
        $itemTexture.Dispose()
    }

}

$colors = @(
    @{ Key = 'w'; Name = '白色'; Color = [System.Drawing.Color]::FromArgb(255, 245, 242, 218) },
    @{ Key = 'r'; Name = '红色'; Color = [System.Drawing.Color]::FromArgb(255, 255, 74, 92) },
    @{ Key = 'b'; Name = '蓝色'; Color = [System.Drawing.Color]::FromArgb(255, 75, 166, 255) },
    @{ Key = 'y'; Name = '黄色'; Color = [System.Drawing.Color]::FromArgb(255, 255, 213, 67) },
    @{ Key = 'g'; Name = '绿色'; Color = [System.Drawing.Color]::FromArgb(255, 112, 229, 91) }
)

$fireworkLayouts = @{
    # 单元素布局必须用一元逗号保留“坐标数组”这一层。
    # 否则PowerShell会把@(40,54)展开成两个整数，导致Y坐标为空并把烟花画到牌顶。
    1 = @(,@(40, 54))
    2 = @(@(27, 32), @(54, 47))
    3 = @(@(40, 24), @(23, 48), @(57, 49))
    4 = @(@(24, 24), @(56, 24), @(25, 51), @(55, 51))
    5 = @(@(40, 20), @(22, 36), @(58, 36), @(29, 55), @(51, 55))
}

$frontBitmap = [System.Drawing.Bitmap]::new($frontSource)
$backBitmap = [System.Drawing.Bitmap]::new($backSource)
try {
    $frontBounds = Get-AlphaBounds -Bitmap $frontBitmap
    $backBounds = Get-AlphaBounds -Bitmap $backBitmap
    # 直接在160×256有效牌面上绘制，禁止先压到80×128再二次放大。
    $frontCard = Resize-Nearest -Source $frontBitmap -Width 160 -Height 256 -SourceRectangle $frontBounds
    $backCard = Resize-Nearest -Source $backBitmap -Width 160 -Height 256 -SourceRectangle $backBounds
    try {
        Save-CardTexture -Card $backCard -Name 'back'

        foreach ($entry in $colors) {
            $colorOnly = Copy-Bitmap -Source $frontCard
            try {
                $graphics = [System.Drawing.Graphics]::FromImage($colorOnly)
                try {
                    Draw-Firework -Graphics $graphics -CenterX 80 -CenterY 76 -Color $entry.Color -Seed 40 -Scale 2
                }
                finally {
                    $graphics.Dispose()
                }
                Save-CardTexture -Card $colorOnly -Name "$($entry.Key)_color"
            }
            finally {
                $colorOnly.Dispose()
            }
        }

        for ($rank = 1; $rank -le 5; $rank++) {
            $rankOnly = Copy-Bitmap -Source $frontCard
            try {
                $graphics = [System.Drawing.Graphics]::FromImage($rankOnly)
                try {
                    Draw-Digit -Graphics $graphics -Digit $rank -X 64 -Y 54 -Scale 6 -Color ([System.Drawing.Color]::FromArgb(255, 245, 242, 218))
                }
                finally {
                    $graphics.Dispose()
                }
                Save-CardTexture -Card $rankOnly -Name "n_$rank"
            }
            finally {
                $rankOnly.Dispose()
            }
        }

        foreach ($entry in $colors) {
            for ($rank = 1; $rank -le 5; $rank++) {
                $face = Copy-Bitmap -Source $frontCard
                try {
                    $graphics = [System.Drawing.Graphics]::FromImage($face)
                    try {
                        $seed = 100 * ($colors.IndexOf($entry) + 1) + $rank
                        foreach ($point in $fireworkLayouts[$rank]) {
                            Draw-Firework -Graphics $graphics -CenterX ($point[0] * 2) -CenterY ($point[1] * 2) -Color $entry.Color -Seed $seed -Scale 2
                            $seed++
                        }
                        Draw-Digit -Graphics $graphics -Digit $rank -X 14 -Y 14 -Scale 4 -Color $entry.Color
                        Draw-Digit -Graphics $graphics -Digit $rank -X 126 -Y 214 -Scale 4 -Color $entry.Color -Rotate180 $true
                    }
                    finally {
                        $graphics.Dispose()
                    }
                    Save-CardTexture -Card $face -Name "$($entry.Key)_$rank"
                }
                finally {
                    $face.Dispose()
                }
            }
        }
    }
    finally {
        $frontCard.Dispose()
        $backCard.Dispose()
    }
}
finally {
    $frontBitmap.Dispose()
    $backBitmap.Dispose()
}

Write-Output '花火纹理生成完成：25张完整牌面、5张颜色提示牌、5张数字提示牌和1张牌背。'
