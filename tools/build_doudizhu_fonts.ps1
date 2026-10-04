param([string]$ResourcePack = (Join-Path $PSScriptRoot '../../fimelcard-rp'))
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$resourceRoot = (Resolve-Path $ResourcePack).Path
$textureRoot = Join-Path $resourceRoot 'assets/card/textures/item/poker'
$outputRoot = Join-Path $resourceRoot 'assets/card/textures/font/doudizhu'
$fontRoot = Join-Path $resourceRoot 'assets/card/font/doudizhu'
New-Item -ItemType Directory -Force $outputRoot,$fontRoot | Out-Null
# 复用已有牌面；JQK只取动画首帧。统一画布保证选中前后字宽不变。
$cards = @()
foreach ($rank in 3..15) {
    $face = switch ($rank) {11 {'j'} 12 {'q'} 13 {'k'} 14 {'a'} 15 {'2'} default {"$rank"}}
    foreach ($suit in @('s','d','c','h')) { $cards += "${suit}_${face}" }
}
$cards += @('j_2','j_1')
$atlases = @{}
foreach ($variant in @('normal','selected')) { $atlases[$variant] = [System.Drawing.Bitmap]::new(36*9,48*6) }
for ($index=0; $index -lt $cards.Count; $index++) {
    $source = [System.Drawing.Bitmap]::new((Join-Path $textureRoot ($cards[$index]+'.png')))
    $frame = $source.Width
    $minX=$frame; $minY=$frame; $maxX=0; $maxY=0
    for ($y=0; $y -lt $frame; $y++) { for ($x=0; $x -lt $frame; $x++) {
        if ($source.GetPixel($x,$y).A -gt 0) {
            $minX=[Math]::Min($minX,$x); $minY=[Math]::Min($minY,$y)
            $maxX=[Math]::Max($maxX,$x); $maxY=[Math]::Max($maxY,$y)
        }
    }}
    $column=$index%9; $row=[int][Math]::Floor($index/9)
    foreach ($variant in @('normal','selected')) {
        $atlas=$atlases[$variant]
        $graphics=[System.Drawing.Graphics]::FromImage($atlas)
        $graphics.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
        $graphics.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half
        $left=$column*36; $top=$row*48
        if ($variant -eq 'selected') {
            $outer=[System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(120,255,192,32))
            $inner=[System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,255,231,104))
            $graphics.FillRectangle($outer,$left,$top,36,48)
            $graphics.FillRectangle($inner,$left+1,$top+1,34,46)
            $outer.Dispose(); $inner.Dispose()
        }
        $dest=[System.Drawing.Rectangle]::new($left+3,$top+2,30,44)
        $graphics.DrawImage($source,$dest,$minX,$minY,$maxX-$minX+1,$maxY-$minY+1,[System.Drawing.GraphicsUnit]::Pixel)
        $graphics.Dispose()
        # 透明度为1的定位点使两个手牌字体的advance都为43（56高时）。
        for ($slice=0; $slice -lt 8; $slice++) {
            $atlas.SetPixel($left+35,$top+6*$slice+5,[System.Drawing.Color]::FromArgb(1,255,255,255))
        }
    }
    $source.Dispose()
}
$chars=@()
for ($row=0; $row -lt 6; $row++) {
    $line=''
    for ($column=0; $column -lt 9; $column++) { $line += [char](0xE101+$row*9+$column) }
    $chars += $line
}
foreach ($variant in @('normal','selected')) {
    $atlases[$variant].Save((Join-Path $outputRoot ($variant+'.png')),[System.Drawing.Imaging.ImageFormat]::Png)
    for ($depth=0; $depth -lt 4; $depth++) {
        $name=if ($variant -eq 'normal') {"hand_$depth"} else {"hand_selected_$depth"}
        $definition=@{providers=@(@{type='bitmap';file="card:font/doudizhu/$variant.png";chars=$chars;height=56;ascent=(56-10*$depth)})}
        $definition | ConvertTo-Json -Depth 8 | Set-Content -Encoding utf8 (Join-Path $fontRoot ($name+'.json'))
    }
    $name=if ($variant -eq 'normal') {'dialog'} else {'dialog_selected'}
    # 对话框逐行绘制9高的切片；每个点击区与可见牌面一致，不依赖按钮高度。
    $sliceChars=@()
    for ($row=0; $row -lt 6; $row++) { for ($slice=0; $slice -lt 8; $slice++) {
        $line=''
        for ($column=0; $column -lt 9; $column++) { $line += [char](0xE200+($row*9+$column)*8+$slice) }
        $sliceChars += $line
    }}
    @{providers=@(@{type='bitmap';file="card:font/doudizhu/$variant.png";chars=$sliceChars;height=9;ascent=7})} | ConvertTo-Json -Depth 8 | Set-Content -Encoding utf8 (Join-Path $fontRoot ($name+'.json'))
    $atlases[$variant].Dispose()
}
@{providers=@(@{type='space';advances=@{([string][char]0xE000)=-43;([string][char]0xE001)=3}})} | ConvertTo-Json -Depth 8 | Set-Content -Encoding utf8 (Join-Path $fontRoot 'spacing.json')
Write-Output '已生成54张牌的普通／选中字形，手牌56高，堆叠间距10。'

# 资源排版预览，不替代Minecraft内的界面验收。
$previewRoot=Join-Path $PSScriptRoot '../docs'
New-Item -ItemType Directory -Force $previewRoot | Out-Null
$preview=[System.Drawing.Bitmap]::new(800,460)
$g=[System.Drawing.Graphics]::FromImage($preview)
$g.Clear([System.Drawing.Color]::FromArgb(30,33,39))
$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half
$labelFont=[System.Drawing.Font]::new('Microsoft YaHei',12)
$g.DrawString('Actionbar：同点数向下堆叠，左大右小',$labelFont,[System.Drawing.Brushes]::White,24,12)
$g.DrawString('出牌对话框：点击牌面选择／取消，金色边框表示选中',$labelFont,[System.Drawing.Brushes]::White,24,170)
$normal=[System.Drawing.Bitmap]::new((Join-Path $outputRoot 'normal.png'))
$selected=[System.Drawing.Bitmap]::new((Join-Path $outputRoot 'selected.png'))
$example=@(54,53,49,50,51,52,45,46,47,48,41,42,37,38,35,29,25,18,10,1)
$x=50; $lastRank=-1; $depth=0
for ($i=0; $i -lt $example.Count; $i++) {
    $id=$example[$i]; $rank=if($id -ge 53){$id-37}else{[int][Math]::Floor(($id-1)/4)+3}
    if ($rank -ne $lastRank) { if($i -gt 0){$x+=46}; $depth=0 }
    $atlas=if($id -in @(50,45)){$selected}else{$normal}
    $sx=(($id-1)%9)*36; $sy=[int][Math]::Floor(($id-1)/9)*48
    $g.DrawImage($atlas,[System.Drawing.Rectangle]::new($x,50+$depth*10,42,56),$sx,$sy,36,48,[System.Drawing.GraphicsUnit]::Pixel)
    $g.DrawImage($atlas,[System.Drawing.Rectangle]::new(190+($i%7)*58,208+[int][Math]::Floor($i/7)*72,54,72),$sx,$sy,36,48,[System.Drawing.GraphicsUnit]::Pixel)
    $lastRank=$rank; $depth++
}
$g.Dispose();$labelFont.Dispose();$normal.Dispose();$selected.Dispose()
$preview.Save((Join-Path $previewRoot 'doudizhu-preview.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$preview.Dispose()
