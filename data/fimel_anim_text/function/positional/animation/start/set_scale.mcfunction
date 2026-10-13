data modify storage fimel_anim_text:runtime positional.animation.scale set from storage fimel_anim_text:runtime positional.animation.data.scale

# 设置放缩

data modify storage fimel_anim_text:runtime positional.animation.transformation.scale[0] set from storage fimel_anim_text:runtime positional.animation.scale
data modify storage fimel_anim_text:runtime positional.animation.transformation.scale[1] set from storage fimel_anim_text:runtime positional.animation.scale
data modify storage fimel_anim_text:runtime positional.animation.transformation.scale[2] set from storage fimel_anim_text:runtime positional.animation.scale

#data modify entity @s transformation set from storage fimel_anim_text:runtime positional.animation.transformation