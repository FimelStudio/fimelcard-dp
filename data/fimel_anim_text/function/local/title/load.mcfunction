## 非玩家跳出

execute unless entity @s[type=player] run return fail

## 输入数据

$data modify storage fimel_anim_text:runtime local.title.data set value $(data)

## 进程检测

function fimel_anim_text:local/title/start/replace_test

execute if score #local.title.print fca_store matches 1.. unless score #local.title.replace fca_store matches 1.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:local/title/fail/block

## 删除进程

execute if score #local.title.print fca_store matches 1.. run function fimel_anim_text:local/title/start/reset

## 设置数据

function fimel_anim_text:local/title/start/set

execute if score #local.title.text fca_store matches 0 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:local/tip/fail/no_input

execute unless score #local.title.style fca_store matches 0..2 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:local/tip/fail/false_style

execute unless score #local.title.speed fca_store matches 0.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:local/tip/fail/false_speed

execute if score #operation.split.verify.change fca_store matches 1 if score #settings.tip.warn fca_store matches 1 run function fimel_anim_text:local/tip/warn/irregular_input

## 执行操作

function fimel_anim_text:local/title/start/player