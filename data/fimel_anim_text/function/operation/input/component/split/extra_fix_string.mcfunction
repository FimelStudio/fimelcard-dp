# 生成组件

data remove storage fimel_anim_text:runtime operation.component.split.extra_string

data modify storage fimel_anim_text:runtime operation.component.split.extra_string.text set from storage fimel_anim_text:runtime operation.component.split.extra_fix

data remove storage fimel_anim_text:runtime operation.component.split.extra_fix

data modify storage fimel_anim_text:runtime operation.component.split.extra_fix set from storage fimel_anim_text:runtime operation.component.split.extra_string