## 未加载跳出

execute unless loaded ~ ~ ~ run return run execute if score #settings.tip.error fca_store matches 1 run function fimel_anim_text:positional/tip/fail/unloaded

## 输入数据

$data modify storage fimel_anim_text:runtime positional.typewriter.data set value $(data)

## 设置数据

function fimel_anim_text:positional/typewriter/start/set

execute if score #positional.typewriter.text fca_store matches 0 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/no_input

execute unless score #positional.typewriter.style fca_store matches 0..2 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/false_style

execute unless score #positional.typewriter.speed fca_store matches 0.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/false_speed


execute if score #operation.split.verify.change fca_store matches 1 if score #settings.tip.warn fca_store matches 1 run function fimel_anim_text:positional/tip/warn/irregular_input

## 执行操作

execute summon text_display run function fimel_anim_text:positional/typewriter/start/summon