$ErrorActionPreference='Stop'
$root='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\saves\卡牌游戏\datapacks\fimelcard-dp\data\doudizhu\function'
$rp='C:\Users\Chen Yuru\AppData\Roaming\.minecraft\versions\26.2-Fabric 0.19.3\resourcepacks\fimelcard-rp'
$sourceRp='C:\Users\Chen Yuru\Desktop\fimelcard-rp'
$entries='[{"path":"hand/append.mcfunction","hash":"3A2CE6B5483F352F01B38A284D9160015BACA6D308FC9D38BED1C152B64083E5"},{"path":"dialog/show.mcfunction","hash":"3193EAECE8BA23B6FF35ACFAB60569466D144B8D3790EA5828EDAC03503D5D0C"},{"path":"dialog/grid.mcfunction","hash":"48E954CCEC7983C2680C934E3BA189C83B459DAB92695C2B3A9E09A5434B87B3"},{"path":"dialog/stack_group.mcfunction","hash":null},{"path":"dialog/stack_cell.mcfunction","hash":null},{"path":"dialog/stack_blank.mcfunction","hash":null},{"path":"dialog/stack_fragment.mcfunction","hash":null}]' | ConvertFrom-Json
$fonts=@('stack','stack_selected','stack_spacing')
foreach($e in $entries){
 $dest=Join-Path $root $e.path
 if($e.hash){if((Get-FileHash -LiteralPath $dest).Hash -ne $e.hash){throw "目标已改变：$dest"}}
 elseif(Test-Path -LiteralPath $dest){throw "新增文件已存在：$dest"}
}
foreach($name in $fonts){if(Test-Path -LiteralPath (Join-Path $rp "assets/card/font/doudizhu/$name.json")){throw "字体已存在：$name"}}
foreach($name in @('normal','selected')){
 $relative="assets/card/textures/font/doudizhu/$name.png"
 if((Get-FileHash -LiteralPath (Join-Path $rp $relative)).Hash -ne (Get-FileHash -LiteralPath (Join-Path $sourceRp $relative)).Hash){throw '实际贴图与布局基线不一致'}
}
$backup=Join-Path $PSScriptRoot ('doudizhu-stack-backup-'+(Get-Date -Format 'yyyyMMdd-HHmmss'))
foreach($e in $entries){
 $dest=[IO.Path]::GetFullPath((Join-Path $root $e.path))
 if(-not $dest.StartsWith($root+'\',[StringComparison]::OrdinalIgnoreCase)){throw '越界'}
 if($e.hash){$saved=Join-Path $backup $e.path;New-Item -ItemType Directory -Path (Split-Path $saved) -Force|Out-Null;Copy-Item -LiteralPath $dest -Destination $saved}
 New-Item -ItemType Directory -Path (Split-Path $dest) -Force|Out-Null
 $source=Join-Path (Join-Path $PSScriptRoot 'doudizhu-stack') $e.path
 Copy-Item -LiteralPath $source -Destination $dest -Force
 if((Get-FileHash -LiteralPath $source).Hash -ne (Get-FileHash -LiteralPath $dest).Hash){throw '函数校验失败'}
}
foreach($name in $fonts){
 $relative="assets/card/font/doudizhu/$name.json"
 $source=Join-Path $sourceRp $relative
 $dest=Join-Path $rp $relative
 Copy-Item -LiteralPath $source -Destination $dest
 if((Get-FileHash -LiteralPath $source).Hash -ne (Get-FileHash -LiteralPath $dest).Hash){throw '字体校验失败'}
}
Write-Output "已更新 $($entries.Count) 个函数、3个字体；备份：$backup"
