$ErrorActionPreference = 'Stop'
$targetRoot = [IO.Path]::GetFullPath('C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data')
$stageRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot 'doudizhu-bot-stage/data'))
$entries = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'doudizhu-bot-stage/manifest.json') -Raw | ConvertFrom-Json
$backupRoot = Join-Path $PSScriptRoot ('doudizhu-bot-backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
# 先检查全部文件，确认实际存档未在准备期间被其他操作修改。
foreach ($entry in $entries) {
    if ($entry.path -notmatch '^(doudizhu/function/|cardtable/function/menu/picker/show[48]\.mcfunction$)') { throw "不允许的目标：$($entry.path)" }
    $target = [IO.Path]::GetFullPath((Join-Path $targetRoot $entry.path))
    $source = [IO.Path]::GetFullPath((Join-Path $stageRoot $entry.path))
    if (-not $target.StartsWith($targetRoot + '\',[StringComparison]::OrdinalIgnoreCase)) { throw '目标越界' }
    if (-not $source.StartsWith($stageRoot + '\',[StringComparison]::OrdinalIgnoreCase)) { throw '来源越界' }
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne $entry.after) { throw "待安装文件改变：$source" }
    if ($null -eq $entry.before) {
        if (Test-Path -LiteralPath $target) { throw "新增目标已存在：$target" }
    } else {
        if (-not (Test-Path -LiteralPath $target)) { throw "原文件缺失：$target" }
        if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $entry.before) { throw "存档文件已被修改，请重新核对：$target" }
    }
}
foreach ($entry in $entries) {
    $target = Join-Path $targetRoot $entry.path
    if (Test-Path -LiteralPath $target) {
        $backup = Join-Path $backupRoot $entry.path
        New-Item -ItemType Directory -Force -Path (Split-Path $backup) | Out-Null
        Copy-Item -LiteralPath $target -Destination $backup
    }
}
foreach ($entry in $entries) {
    $target = Join-Path $targetRoot $entry.path
    New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
    Copy-Item -LiteralPath (Join-Path $stageRoot $entry.path) -Destination $target -Force
    if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $entry.after) { throw "写入校验失败：$target" }
}
Write-Output "已安装并校验 $($entries.Count) 个文件。"
Write-Output "目标：$targetRoot"
Write-Output "原文件备份：$backupRoot"
