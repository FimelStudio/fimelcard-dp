$ErrorActionPreference='Stop'
$targetRoot='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function'
$sourceRoot=Join-Path $PSScriptRoot 'doudizhu-cant-play'
$target=Join-Path $targetRoot 'dialog/play_buttons.mcfunction'
if((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne '878B34C2C4A8B4A88DA92075F745F5ADD0FBCEC0092DCD5EA880AF6705CCA0A1'){throw '目标已改变，请重新核对'}
if(Test-Path -LiteralPath (Join-Path $targetRoot 'dialog/can_play.mcfunction')){throw '检测函数已存在，请重新核对'}
$backup=Join-Path $PSScriptRoot ('doudizhu-cant-play-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
Copy-Item -LiteralPath $target -Destination (Join-Path $backup 'play_buttons.mcfunction')
foreach($relative in @('dialog/can_play.mcfunction','dialog/play_buttons.mcfunction')){
 $destination=[IO.Path]::GetFullPath((Join-Path $targetRoot $relative))
 if(-not $destination.StartsWith($targetRoot+'\',[StringComparison]::OrdinalIgnoreCase)){throw '目标越界'}
 $source=Join-Path $sourceRoot $relative
 Copy-Item -LiteralPath $source -Destination $destination -Force
 if((Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash){throw '校验失败'}
}
Write-Output "已更新存档中2个函数；备份：$backup"
