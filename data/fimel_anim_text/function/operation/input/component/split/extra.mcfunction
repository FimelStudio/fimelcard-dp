# 检测跳出

execute if score #operation.split.component.extra fca_store matches 0 run return run function fimel_anim_text:operation/input/list/split/run

# extra修正

data modify storage fimel_anim_text:runtime operation.component.split.extra_fixed set value []

function fimel_anim_text:operation/input/component/split/extra_fix

# 插入组件

data modify storage fimel_anim_text:runtime operation.list.split.input prepend from storage fimel_anim_text:runtime operation.component.split.extra_fixed[]

# 继续列表

function fimel_anim_text:operation/input/list/split/run