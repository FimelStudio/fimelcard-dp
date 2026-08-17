param(
    [Parameter(Mandatory = $true)]
    [string]$TextureDirectory
)

# 始终以现有牌面为底图，只重绘夜空中央的小区域，保证边框、富士山和透明区逐像素保留。
Add-Type -AssemblyName System.Drawing

function Copy-CleanSky {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [int]$Left,
        [int]$Top,
        [int]$Right,
        [int]$Bottom
    )
    for ($y = $Top; $y -le $Bottom; $y++) {
        # 天空是横向色带；从图标两侧取样并平均，可清掉原烟花而不引入缩放模糊。
        $a = $Bitmap.GetPixel(82, $y)
        $b = $Bitmap.GetPixel(174, $y)
        $color = [System.Drawing.Color]::FromArgb(
            255,
            [int](($a.R + $b.R) / 2),
            [int](($a.G + $b.G) / 2),
            [int](($a.B + $b.B) / 2)
        )
        for ($x = $Left; $x -le $Right; $x++) {
            $Bitmap.SetPixel($x, $y, $color)
        }
    }
}

function Fill-Block {
    param(
        [System.Drawing.Graphics]$Graphics,
        [System.Drawing.Brush]$Brush,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height
    )
    $Graphics.FillRectangle($Brush, $X, $Y, $Width, $Height)
}

function New-HintTool {
    param([string]$OutputPath)
    $source = [System.Drawing.Bitmap]::new((Join-Path $TextureDirectory "b_color.png"))
    $result = $source.Clone([System.Drawing.Rectangle]::new(0, 0, $source.Width, $source.Height), [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $source.Dispose()
    Copy-CleanSky $result 94 46 164 122

    $graphics = [System.Drawing.Graphics]::FromImage($result)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $shadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 18, 64, 102))
    $cyan = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 62, 225, 242))
    $goldShadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 151, 104, 20))
    $gold = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 220, 55))

    try {
        $rays = @(
            @(127, 48, 4, 18), @(127, 105, 4, 18),
            @(96, 83, 18, 4), @(144, 83, 18, 4),
            @(104, 59, 4, 4), @(108, 63, 4, 4), @(112, 67, 4, 4),
            @(146, 59, 4, 4), @(142, 63, 4, 4), @(138, 67, 4, 4),
            @(104, 107, 4, 4), @(108, 103, 4, 4), @(112, 99, 4, 4),
            @(146, 107, 4, 4), @(142, 103, 4, 4), @(138, 99, 4, 4)
        )
        foreach ($ray in $rays) {
            Fill-Block $graphics $shadow ($ray[0] + 2) ($ray[1] + 2) $ray[2] $ray[3]
            Fill-Block $graphics $cyan $ray[0] $ray[1] $ray[2] $ray[3]
        }

        # “+1”由像素块构造，不调用系统字体，避免抗锯齿。
        Fill-Block $graphics $goldShadow 108 80 20 7
        Fill-Block $graphics $goldShadow 114 74 7 20
        Fill-Block $graphics $gold 106 78 20 7
        Fill-Block $graphics $gold 112 72 7 20
        Fill-Block $graphics $goldShadow 135 74 7 20
        Fill-Block $graphics $goldShadow 130 80 12 7
        Fill-Block $graphics $gold 133 72 7 20
        Fill-Block $graphics $gold 128 78 12 7
        $result.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $shadow.Dispose()
        $cyan.Dispose()
        $goldShadow.Dispose()
        $gold.Dispose()
        $graphics.Dispose()
        $result.Dispose()
    }
}

function New-RestoreTool {
    param([string]$OutputPath)
    $source = [System.Drawing.Bitmap]::new((Join-Path $TextureDirectory "b_color.png"))
    $result = $source.Clone([System.Drawing.Rectangle]::new(0, 0, $source.Width, $source.Height), [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $source.Dispose()
    Copy-CleanSky $result 91 43 167 125

    $graphics = [System.Drawing.Graphics]::FromImage($result)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $dark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 32, 49, 86))
    $purple = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 186, 91, 236))
    $green = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 80, 226, 145))
    $cream = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 255, 239, 192))
    $cardInner = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 235, 205, 137))

    try {
        foreach ($block in @(
            @(101, 60, 8, 8), @(109, 52, 32, 8), @(141, 56, 8, 8), @(149, 64, 8, 16),
            @(149, 76, 16, 8), @(157, 72, 8, 16)
        )) {
            Fill-Block $graphics $dark ($block[0] + 2) ($block[1] + 2) $block[2] $block[3]
            Fill-Block $graphics $purple $block[0] $block[1] $block[2] $block[3]
        }
        foreach ($block in @(
            @(99, 96, 8, 16), @(99, 108, 16, 8), @(107, 112, 8, 8),
            @(115, 116, 32, 8), @(147, 108, 8, 8), @(155, 96, 8, 16)
        )) {
            Fill-Block $graphics $dark ($block[0] + 2) ($block[1] + 2) $block[2] $block[3]
            Fill-Block $graphics $green $block[0] $block[1] $block[2] $block[3]
        }

        Fill-Block $graphics $dark 119 70 24 40
        Fill-Block $graphics $cream 116 67 24 40
        Fill-Block $graphics $cardInner 121 73 14 28
        Fill-Block $graphics $cream 124 77 8 20
        $result.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $dark.Dispose()
        $purple.Dispose()
        $green.Dispose()
        $cream.Dispose()
        $cardInner.Dispose()
        $graphics.Dispose()
        $result.Dispose()
    }
}

New-HintTool (Join-Path $TextureDirectory "tool_hint.png")
New-RestoreTool (Join-Path $TextureDirectory "tool_restore.png")
Write-Output "已生成 tool_hint.png 与 tool_restore.png。"
