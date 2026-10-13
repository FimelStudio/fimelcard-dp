## 输入数据

$data modify storage fimel_anim_text:runtime global.title.data set value $(data)

## 进程检测

function fimel_anim_text:global/title/start/replace_test

execute if score #global.title.print fca_store matches 1.. unless score #global.title.replace fca_store matches 1 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:global/title/fail/block

## 设置数据

function fimel_anim_text:global/title/start/set

execute if score #global.title.text fca_store matches 0 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:global/tip/fail/no_input

execute unless score #global.title.style fca_store matches 0..2 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:global/tip/fail/false_style

execute unless score #global.title.speed fca_store matches 0.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:global/tip/fail/false_speed

execute if score #operation.split.verify.change fca_store matches 1 if score #settings.tip.warn fca_store matches 1 run function fimel_anim_text:global/tip/warn/irregular_input

## 执行操作

# 标题时常变更

title @a times 0 70 20

data modify storage fimel_anim_text:runtime global.title.template set value []

scoreboard players set #global.title.print fca_store 1