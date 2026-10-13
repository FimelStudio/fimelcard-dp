# 生成组件

data remove storage fimel_anim_text:runtime operation.component.split.extra_list

data modify storage fimel_anim_text:runtime operation.component.split.extra_list set from storage fimel_anim_text:runtime operation.component.split.extra_fix

data remove storage fimel_anim_text:runtime operation.component.split.extra_fix

# OmG ThAtS NoT A CoMpoNenT

data modify storage fimel_anim_text:runtime operation.component.split.extra_fix set value {extra:[]}

data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.extra append from storage fimel_anim_text:runtime operation.component.split.extra_list[]