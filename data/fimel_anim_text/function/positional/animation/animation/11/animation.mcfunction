
# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 动画

execute unless data storage fimel_anim_text:runtime positional.animation.transformation.interpolation[0] run data modify entity @s interpolation_duration set value 0

execute if data storage fimel_anim_text:runtime positional.animation.transformation.interpolation[0] run data modify entity @s transformation.translation set from storage fimel_anim_text:runtime positional.animation.transformation.interpolation[0]

data remove storage fimel_anim_text:runtime positional.animation.transformation.interpolation[0]

# 声音

execute store result score #positional.animation.time.sound fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.sound

execute if score #positional.animation.time.sound fca_store = @s fca_timer run function fimel_anim_text:positional/animation/process/sound

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation