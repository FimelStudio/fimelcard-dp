# 字符串与组件检测

data remove storage fimel_anim_text:runtime operation.text.component

execute store success score #operation.component fca_store run data modify storage fimel_anim_text:runtime operation.text.component set string storage fimel_anim_text:runtime operation.text.input

execute if score #operation.component fca_store matches 0 unless data storage fimel_anim_text:runtime operation.text.input[] run scoreboard players set #operation.component fca_store 2

# 重置组件

data modify storage fimel_anim_text:runtime operation.text.output set value []

# 列表

execute if score #operation.component fca_store matches 0 run function fimel_anim_text:operation/input/list

# 切分字符串

execute if score #operation.component fca_store matches 1 run function fimel_anim_text:operation/input/string

# 切分组件

execute if score #operation.component fca_store matches 2 run function fimel_anim_text:operation/input/component

# 重筛组件

scoreboard players set #operation.split.verify.change fca_store 0

function fimel_anim_text:operation/input/verify/start

# 检测变化

execute store success score #operation.split.verify.change fca_store run data modify storage fimel_anim_text:runtime operation.text.copy_0 set from storage fimel_anim_text:runtime operation.text.output