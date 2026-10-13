# 检测类型

data remove storage fimel_anim_text:runtime operation.list.split.temp 

execute store result score #operation.split.list.text fca_store run data modify storage fimel_anim_text:runtime operation.list.split.temp set string storage fimel_anim_text:runtime operation.list.split.input_0

execute if score #operation.split.list.text fca_store matches 0 if data storage fimel_anim_text:runtime operation.list.split.input_0{} run scoreboard players set #operation.split.list.text fca_store 2

# 开始匹配

execute if score #operation.split.list.text fca_store matches 0 run return run function fimel_anim_text:operation/input/list/split/list

execute if score #operation.split.list.text fca_store matches 1 run return run function fimel_anim_text:operation/input/list/split/string

execute if score #operation.split.list.text fca_store matches 2 run return run function fimel_anim_text:operation/input/list/split/component