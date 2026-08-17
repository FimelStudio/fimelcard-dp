param(
    [Parameter(Mandatory = $true)]
    [string]$TextureDirectory
)

# 以现有蓝色牌为底图、红色牌为颜色区域参照，只替换原本的牌面符号。
# 这样可以完整保留透明区、边框、天空、富士山和原始像素清晰度。
Add-Type -AssemblyName System.Drawing

$palette = @(
    [System.Drawing.Color]::FromArgb(255, 255, 75, 75),
    [System.Drawing.Color]::FromArgb(255, 75, 166, 255),
    [System.Drawing.Color]::FromArgb(255, 255, 218, 55),
    [System.Drawing.Color]::FromArgb(255, 75, 220, 105),
    [System.Drawing.Color]::FromArgb(255, 245, 245, 255)
)

function Get-PaletteIndex {
    param([int]$X, [int]$Y)

    # 中央烟花按辐射方向分色，角落数字按横向色带分色。
    if ($Y -ge 55 -and $Y -le 185) {
        $angle = [Math]::Atan2($Y - 108, $X - 128)
        $normalized = ($angle + [Math]::PI) / (2 * [Math]::PI)
        return [Math]::Min(4, [int][Math]::Floor($normalized * 5))
    }
    return ([Math]::Abs([int][Math]::Floor($Y / 4)) % 5)
}

function Convert-ColoredPixel {
    param(
        [System.Drawing.Color]$Source,
        [System.Drawing.Color]$Target
    )

    # 原蓝色主色亮度约为166；按源像素亮度缩放，保留原牌的明暗层次。
    $luminance = 0.2126 * $Source.R + 0.7152 * $Source.G + 0.0722 * $Source.B
    $factor = [Math]::Max(0.18, [Math]::Min(1.18, $luminance / 166.0))
    $r = [Math]::Min(255, [int][Math]::Round($Target.R * $factor))
    $g = [Math]::Min(255, [int][Math]::Round($Target.G * $factor))
    $b = [Math]::Min(255, [int][Math]::Round($Target.B * $factor))
    return [System.Drawing.Color]::FromArgb($Source.A, $r, $g, $b)
}

function Set-PixelSafe {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [int]$X,
        [int]$Y,
        [System.Drawing.Color]$Color
    )
    if ($X -ge 0 -and $X -lt $Bitmap.Width -and $Y -ge 0 -and $Y -lt $Bitmap.Height) {
        $Bitmap.SetPixel($X, $Y, $Color)
    }
}

function Add-Pinwheel {
    param([System.Drawing.Bitmap]$Bitmap)

    # 数字下方的小型五色风车：四条彩色风叶和白色轮轴。
    $centerX = 74
    $centerY = 58
    foreach ($dx in -1..1) {
        foreach ($dy in -1..1) {
            Set-PixelSafe $Bitmap ($centerX + $dx) ($centerY + $dy) $palette[4]
        }
    }

    $arms = @(
        @{ Color = $palette[0]; DX = -1; DY = -1 },
        @{ Color = $palette[1]; DX = 1; DY = -1 },
        @{ Color = $palette[2]; DX = 1; DY = 1 },
        @{ Color = $palette[3]; DX = -1; DY = 1 }
    )
    foreach ($arm in $arms) {
        foreach ($step in 2..7) {
            $x = $centerX + $arm.DX * $step
            $y = $centerY + $arm.DY * $step
            Set-PixelSafe $Bitmap $x $y $arm.Color
            Set-PixelSafe $Bitmap ($x + $arm.DY) $y $arm.Color
        }
    }
}

function New-StormTexture {
    param(
        [string]$BlueName,
        [string]$RedName,
        [string]$OutputName,
        [bool]$WithPinwheel
    )

    $bluePath = Join-Path $TextureDirectory $BlueName
    $redPath = Join-Path $TextureDirectory $RedName
    $outputPath = Join-Path $TextureDirectory $OutputName
    $blue = [System.Drawing.Bitmap]::new($bluePath)
    $red = [System.Drawing.Bitmap]::new($redPath)
    $result = [System.Drawing.Bitmap]::new($blue.Width, $blue.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

    try {
        for ($y = 0; $y -lt $blue.Height; $y++) {
            for ($x = 0; $x -lt $blue.Width; $x++) {
                $source = $blue.GetPixel($x, $y)
                if ($source.ToArgb() -ne $red.GetPixel($x, $y).ToArgb()) {
                    $paletteIndex = Get-PaletteIndex $x $y
                    # 颜色提示牌只有一枚较小烟花，改用紧凑色带确保五种颜色都能出现。
                    if (-not $WithPinwheel) {
                        $paletteIndex = [Math]::Abs([int][Math]::Floor(($x - 104) / 7)) % 5
                    }
                    $target = $palette[$paletteIndex]
                    $result.SetPixel($x, $y, (Convert-ColoredPixel $source $target))
                }
                else {
                    $result.SetPixel($x, $y, $source)
                }
            }
        }
        if ($WithPinwheel) {
            Add-Pinwheel $result
        }
        $result.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $blue.Dispose()
        $red.Dispose()
        $result.Dispose()
    }
}

foreach ($rank in 1..5) {
    New-StormTexture "b_$rank.png" "r_$rank.png" "m_$rank.png" $true
}
New-StormTexture "b_color.png" "r_color.png" "m_color.png" $false

Write-Output "已生成 m_1.png 至 m_5.png 与 m_color.png。"


