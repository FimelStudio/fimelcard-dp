$ErrorActionPreference='Stop'
$target='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function\action\play.mcfunction'
$source=Join-Path $PSScriptRoot 'doudizhu-bomb-sound/play.mcfunction'
if((Get-FileHash -LiteralPath $target).Hash -ne 'E524E1A53C532576A7D6FEBC20E903B9675B7DCF41F566573559CCE34B961CE3'){throw '目标已变更，请重新核对'}
$backup=Join-Path $PSScriptRoot ('doudizhu-bomb-sound-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
Copy-Item -LiteralPath $target -Destination (Join-Path $backup 'play.mcfunction')
Copy-Item -LiteralPath $source -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ne (Get-FileHash -LiteralPath $source).Hash){throw '写入校验失败'}
Write-Output "已加入炸弹音效；备份：$backup"
