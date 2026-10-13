# 重置数据

data remove storage fimel_anim_text:runtime operation.component.split.input_text

data modify storage fimel_anim_text:runtime operation.component.split.extra set value []

data modify storage fimel_anim_text:runtime operation.component.split.template set value {}

# 检测extra

execute store result score #operation.split.component.extra fca_store run data modify storage fimel_anim_text:runtime operation.component.split.extra set from storage fimel_anim_text:runtime operation.component.split.input.extra

# 检测text

execute store result score #operation.split.component.text fca_store run data modify storage fimel_anim_text:runtime operation.component.split.input_text set string storage fimel_anim_text:runtime operation.component.split.input.text

# 文本模板堆栈

function fimel_anim_text:operation/input/split/template

# 开始递归

function fimel_anim_text:operation/input/component/split/split