$ErrorActionPreference='Stop'
$target='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function\hud\row_text.mcfunction'
$source=Join-Path $PSScriptRoot 'doudizhu-role/row_text.mcfunction'
if((Get-FileHash -LiteralPath $target).Hash -ne 'BC471E419C7AAE2CBBFD2C37382AAA7DEF3A2904D4734BE646707C8970DBDB7A'){throw '目标已变更，请重新核对'}
$backup=Join-Path $PSScriptRoot ('doudizhu-role-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
Copy-Item -LiteralPath $target -Destination (Join-Path $backup 'row_text.mcfunction')
Copy-Item -LiteralPath $source -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ne (Get-FileHash -LiteralPath $source).Hash){throw '写入校验失败'}
Write-Output "已加入身份显示；备份：$backup"
