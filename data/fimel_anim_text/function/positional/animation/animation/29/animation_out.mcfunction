# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 掉落跳出

execute if data storage fimel_anim_text:runtime positional.animation.drop run return run function fimel_anim_text:positional/animation/process/drop

# 动画

data modify entity @s text_opacity set value 0

return run function fimel_anim_text:positional/animation/animation/0/kill

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation