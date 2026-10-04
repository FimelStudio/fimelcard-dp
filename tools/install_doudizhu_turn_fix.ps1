$ErrorActionPreference='Stop'
$targetRoot='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data'
$stageRoot=Join-Path $PSScriptRoot 'doudizhu-turn-fix'
$backupRoot=Join-Path $PSScriptRoot ('doudizhu-turn-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
$entries='[{"path":"doudizhu/function/action/pass.mcfunction","before":"80BC738BA01CE4C7B6B3F4D8CAD82B3DB9708B92C29A498C961D4B2A6302533C"},{"path":"doudizhu/function/round/wrap.mcfunction","before":"EDC2D642F9429985FC727A0E0AE32FF8F96517E81F34432FB1CB8DD8EC24E690"},{"path":"doudizhu/function/round/advance.mcfunction","before":"BEEE17F2D9C7FB7A1F8A4AED412A4B5FA954E3C3E3155803FBEB63A920ED5D01"},{"path":"doudizhu/function/bid/submit.mcfunction","before":"766FC29F813B9AF8806E53BA4E164D45B46B149BB95E1A8F44C21705C751F9D2"},{"path":"doudizhu/function/action/handle.mcfunction","before":"0A43185604205F15E88614FE55A70DB27D0CA38B8AE17DB3D751CE3B351A34C8"},{"path":"doudizhu/function/action/play.mcfunction","before":"99C83683CFD52D203358E6CC85D59DAC4D017B0D6FAA8B5BC16930EC789C5830"}]' | ConvertFrom-Json
foreach($entry in $entries){
    $target=[IO.Path]::GetFullPath((Join-Path $targetRoot $entry.path))
    if(-not $target.StartsWith($targetRoot+'\',[StringComparison]::OrdinalIgnoreCase)){throw '目标越界'}
    if((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $entry.before){throw "目标已被修改：$target"}
    if(-not (Test-Path -LiteralPath (Join-Path $stageRoot $entry.path))){throw '修复文件缺失'}
}
foreach($entry in $entries){
    $backup=Join-Path $backupRoot $entry.path
    New-Item -ItemType Directory -Force -Path (Split-Path $backup) | Out-Null
    Copy-Item -LiteralPath (Join-Path $targetRoot $entry.path) -Destination $backup
}
foreach($entry in $entries){
    $source=Join-Path $stageRoot $entry.path
    $target=Join-Path $targetRoot $entry.path
    Copy-Item -LiteralPath $source -Destination $target -Force
    if((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash){throw '写入校验失败'}
}
Write-Output "已修复并校验6个存档函数。备份：$backupRoot"
