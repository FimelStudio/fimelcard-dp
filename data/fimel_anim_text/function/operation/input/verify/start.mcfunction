# 复制组件

data modify storage fimel_anim_text:runtime operation.text.copy set from storage fimel_anim_text:runtime operation.text.output

data modify storage fimel_anim_text:runtime operation.text.copy_0 set value []

data modify storage fimel_anim_text:runtime operation.text.output set value []

# 递归验证

execute summon text_display run function fimel_anim_text:operation/input/verify/verify