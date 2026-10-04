$ErrorActionPreference='Stop'
$target='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function\dialog\stack_cell.mcfunction'
$source=Join-Path $PSScriptRoot 'doudizhu-center/stack_cell.mcfunction'
if((Get-FileHash -LiteralPath $target).Hash -ne '01DD3EB7365F402931E14869B72AB28D19459DF5C768AA95FADCFE3801A7ABC5'){throw '目标已变更，请重新核对'}
$backup=Join-Path $PSScriptRoot ('doudizhu-center-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
Copy-Item -LiteralPath $target -Destination (Join-Path $backup 'stack_cell.mcfunction')
Copy-Item -LiteralPath $source -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ne (Get-FileHash -LiteralPath $source).Hash){throw '写入校验失败'}
Write-Output "已修复少牌居中；备份：$backup"
