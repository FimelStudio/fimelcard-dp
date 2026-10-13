## 输入数据

$data modify storage fimel_anim_text:runtime storage.output.data.data set value $(data)

## 设置数据

function fimel_anim_text:storage/output/start/set

## 检测重复

function fimel_anim_text:storage/output/start/test with storage fimel_anim_text:runtime storage.output.data

## 检测中断

execute if score #storage.output.text fca_store matches 0 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/tip/fail/no_input

execute if score #storage.output.id.test fca_store matches 1 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/tip/fail/no_id

execute if score #storage.output.id.test fca_store matches 2 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/tip/fail/repeated_id

execute unless score #storage.output.style fca_store matches 0..2 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/tip/fail/false_style

execute unless score #storage.output.speed fca_store matches 0.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/tip/fail/false_speed

execute if score #operation.split.verify.change fca_store matches 1 if score #settings.tip.warn fca_store matches 1 run function fimel_anim_text:storage/tip/warn/irregular_input

## 执行操作

execute positioned 0.5 400.0 0.5 summon marker run function fimel_anim_text:storage/output/start/summon