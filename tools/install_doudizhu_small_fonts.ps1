$ErrorActionPreference='Stop'
$targetRoot='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\resourcepacks\fimelcard-rp\assets\card\font\doudizhu'
$sourceRoot='C:\Users\Chen Yuru\Desktop\fimelcard-rp\assets\card\font\doudizhu'
$entries='[{"name":"hand_0","hash":"A42F56C7134DC0ED010AB4321061FE02B615FA8C8C3AC23CC715D0877E83FF45"},{"name":"hand_1","hash":"7B5E6ECC9045D5D772EA4A061D33704B506A93145313B250252CD5BDA9359E28"},{"name":"hand_2","hash":"AC489DE63A2809BDE87AC133FCA1BB2BA3FD33DD7F7748C71742FA629583DDB8"},{"name":"hand_3","hash":"F5E8DF8C22F6C1FAB3DC7A1C3487841CB92ABA4D9435C6F5CF8A41794051BA67"},{"name":"hand_selected_0","hash":"FD84DA4FAEC24FB400C5D577141334ED9E74662A82EC876E36F4E8BA623F57BB"},{"name":"hand_selected_1","hash":"4EFFED9688E940B9C94C631BB2018794424BDFEB386D3009417D40D8ADCCAEF3"},{"name":"hand_selected_2","hash":"4AE1589B92F89D0D5F6BF0B9E52324F77A2B48B27EAA92FC1F27293EF80D8AF6"},{"name":"hand_selected_3","hash":"346624C1EE3A2D8FEDB21F33E07050ACADD059C607AC408DC0FA32359730E34F"},{"name":"spacing","hash":"EBC5A03FCEF0DAFC7980C1AA22148E24525D1F9CC14BB3BF2F34229EF0F2123C"}]' | ConvertFrom-Json
foreach($entry in $entries){
 $file=Join-Path $targetRoot ($entry.name+'.json')
 if((Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash -ne $entry.hash){throw "目标文件与基线不同：$file"}
 $font=Get-Content -LiteralPath (Join-Path $sourceRoot ($entry.name+'.json')) -Raw | ConvertFrom-Json
 if($entry.name -ne 'spacing' -and $font.providers[0].height -ne 56){throw '字号校验失败'}
}
$backup=Join-Path $PSScriptRoot ('doudizhu-font-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
foreach($entry in $entries){Copy-Item -LiteralPath (Join-Path $targetRoot ($entry.name+'.json')) -Destination $backup}
foreach($entry in $entries){
 $source=Join-Path $sourceRoot ($entry.name+'.json')
 $target=Join-Path $targetRoot ($entry.name+'.json')
 Copy-Item -LiteralPath $source -Destination $target -Force
 if((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash){throw '写入校验失败'}
}
Write-Output "已更新9个手牌字体文件，高度56、层间距10。原文件备份：$backup"
