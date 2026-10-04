$ErrorActionPreference='Stop'
$targetRoot='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function'
$fontTarget='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\resourcepacks\fimelcard-rp\assets\card\font\doudizhu\hand_neg.json'
$fontSource='C:\Users\Chen Yuru\Desktop\fimelcard-rp\assets\card\font\doudizhu\hand_neg.json'
$entries='[{"path":"tick.mcfunction","hash":"5B0B2647F9F6C2B5B8A3364A4D66601F685B257AE933DDF2D335A930D1D56FC5"},{"path":"player/clear_state.mcfunction","hash":"5390F51091956FE76E7EE6D66E56C2C9F922789482BD1728F4158F6DF5A73D66"},{"path":"action/handle.mcfunction","hash":"0CBA3EA509C5051C83B25E9A093CE642B3EE85524FCE408B5BE6DECBD5794326"},{"path":"hand/show.mcfunction","hash":"DD115C042E67FC7EADE314569501652CE4A74C8CB2EEFD5B09550776A8F00642"},{"path":"action/play.mcfunction","hash":"4FEB72C4E52AEFFCCCBEB4AAEF88D84ACEF979132E184083B09969C93EC6D3EA"},{"path":"input/drop.mcfunction","hash":"392A5E4493F2E0AC9B1869FE438A9A734701F6AECEC5E37124192ADB6417FF8A"},{"path":"load.mcfunction","hash":"C82BDA13AE706A0750091B762C7A96F5A65A5FC60A94861D6038B812E523ED19"},{"path":"input/give.mcfunction","hash":"A8A3F2863D8F17E2073DE9FFCA85475C1DA767682A1CB811CD43EA0D7DD648F3"},{"path":"input/clear_drops.mcfunction","hash":"6D98D5AB1715701049ADBC750757540AA7309E402EE034B3A3438670C15B32C9"},{"path":"input/give_book.mcfunction","hash":"EA2C59E38228A6DC7F84244A7716A1B50918817EC740653EC058D4FBDBDD2340"},{"path":"dialog/open.mcfunction","hash":"9F6B58DE3D966E269C84D1BC3C413E4B4A1647445CFEE5A69D180028D2F37B7B"},{"path":"player/init.mcfunction","hash":"2DAC0CB340D68D760D4EB8499B0087ED90003250295C3BBAA2B7303CA48EA7E6"},{"path":"round/announce.mcfunction","hash":"1EA228D431BC8A00E28A3AAA01F9AF071F977DB021189EF0A10BFB43B59F98A0"},{"path":"input/check_drop.mcfunction","hash":"BB296046846B4F765A134B7859D71E867EB6F499114AE0C62E5601B81EC0B160"},{"path":"input/clear.mcfunction","hash":null},{"path":"input/return_tool.mcfunction","hash":null},{"path":"input/sync.mcfunction","hash":null},{"path":"input/sync_player.mcfunction","hash":null},{"path":"system/upgrade_v3.mcfunction","hash":null},{"path":"input/reject.mcfunction","hash":null},{"path":"hud/activate.mcfunction","hash":null},{"path":"hud/deactivate.mcfunction","hash":null},{"path":"hud/build.mcfunction","hash":null},{"path":"hud/wrap_up.mcfunction","hash":null},{"path":"hud/wrap_down.mcfunction","hash":null},{"path":"hud/row.mcfunction","hash":null},{"path":"hud/row_text.mcfunction","hash":null}]' | ConvertFrom-Json
foreach($entry in $entries){
 $destination=Join-Path $targetRoot $entry.path
 if($entry.hash){if((Get-FileHash -LiteralPath $destination).Hash -ne $entry.hash){throw "目标已变更: $destination"}}
 elseif(Test-Path -LiteralPath $destination){throw "新增文件已存在: $destination"}
}
if(Test-Path -LiteralPath $fontTarget){throw '字体已存在，请重新核对'}
$backup=Join-Path $PSScriptRoot ('doudizhu-hud-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup | Out-Null
foreach($entry in $entries){
 $destination=[IO.Path]::GetFullPath((Join-Path $targetRoot $entry.path))
 if(-not $destination.StartsWith($targetRoot+'\',[StringComparison]::OrdinalIgnoreCase)){throw '目标越界'}
 if($entry.hash){
  $saved=Join-Path $backup $entry.path
  New-Item -ItemType Directory -Path (Split-Path $saved) -Force | Out-Null
  Copy-Item -LiteralPath $destination -Destination $saved
 }
 New-Item -ItemType Directory -Path (Split-Path $destination) -Force | Out-Null
 $source=Join-Path (Join-Path $PSScriptRoot 'doudizhu-hud') $entry.path
 Copy-Item -LiteralPath $source -Destination $destination -Force
 if((Get-FileHash -LiteralPath $destination).Hash -ne (Get-FileHash -LiteralPath $source).Hash){throw '写入校验失败'}
}
Copy-Item -LiteralPath $fontSource -Destination $fontTarget
if((Get-FileHash -LiteralPath $fontTarget).Hash -ne (Get-FileHash -LiteralPath $fontSource).Hash){throw '字体校验失败'}
Write-Output "已更新 $($entries.Count) 个函数和1个字体；备份：$backup"
