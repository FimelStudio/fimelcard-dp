# 重置数据

data modify storage fimel_anim_text:runtime operation.string.split.template set value {text:""}

data modify storage fimel_anim_text:runtime operation.list.split.input set value []

data modify storage fimel_anim_text:runtime operation.split.template set value []

# 开始递归

function fimel_anim_text:operation/input/string/split/split