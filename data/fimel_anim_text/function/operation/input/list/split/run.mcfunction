# 终止

execute unless data storage fimel_anim_text:runtime operation.list.split.input[0] run return fail

# 重置数据

data modify storage fimel_anim_text:runtime operation.list.split.input_0 set from storage fimel_anim_text:runtime operation.list.split.input[0]

data remove storage fimel_anim_text:runtime operation.list.split.input[0]

# 开始检测

function fimel_anim_text:operation/input/list/split/split