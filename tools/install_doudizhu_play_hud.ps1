$ErrorActionPreference='Stop'
$root='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function'
$entries='[{"path":"action/play.mcfunction","hash":"B7A7236E2D9BB8DD11761495BFE3B24694D13F7D4F3E4CDB6993195969F609D3"},{"path":"action/pass.mcfunction","hash":"0738E62F274B38FF461FCC84FBE2198AC5EF0DC0ADA72F4F1ACCC7B502301519"},{"path":"hud/row.mcfunction","hash":"09F99F6DB8E1D612AD1382413D4E9D7431A1461DA2F67A9D05EEE596A540BA0E"},{"path":"hud/build.mcfunction","hash":"DC4A19F372B45B3FBE2DAEC511490A829831ED937B3560DC0FB16C326D0329DC"},{"path":"hud/read_play.mcfunction","hash":null},{"path":"hud/record_play.mcfunction","hash":null},{"path":"hud/record_pass.mcfunction","hash":null},{"path":"hud/store_play.mcfunction","hash":null},{"path":"hud/build_play.mcfunction","hash":null}]'|ConvertFrom-Json
foreach($e in $entries){
 $dest=Join-Path $root $e.path
 if($e.hash){if((Get-FileHash -LiteralPath $dest).Hash -ne $e.hash){throw "目标已改变: $dest"}}
 elseif(Test-Path -LiteralPath $dest){throw "新增目标已存在: $dest"}
}
$backup=Join-Path $PSScriptRoot ('doudizhu-play-hud-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
foreach($e in $entries){
 $dest=[IO.Path]::GetFullPath((Join-Path $root $e.path))
 if(-not $dest.StartsWith($root+'\',[StringComparison]::OrdinalIgnoreCase)){throw '越界'}
 if($e.hash){
  $saved=Join-Path $backup $e.path
  New-Item -ItemType Directory -Path (Split-Path $saved) -Force|Out-Null
  Copy-Item -LiteralPath $dest -Destination $saved
 }
 New-Item -ItemType Directory -Path (Split-Path $dest) -Force|Out-Null
 $source=Join-Path (Join-Path $PSScriptRoot 'doudizhu-play-hud') $e.path
 Copy-Item -LiteralPath $source -Destination $dest -Force
 if((Get-FileHash -LiteralPath $dest).Hash -ne (Get-FileHash -LiteralPath $source).Hash){throw '写入校验失败'}
}
Write-Output "已更新 $($entries.Count) 个函数。备份: $backup"
