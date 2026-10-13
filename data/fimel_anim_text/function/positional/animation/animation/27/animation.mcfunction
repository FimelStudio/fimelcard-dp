
# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 动画

execute if score @s fca_timer matches 15 run data modify entity @s text.obfuscated set value false

# 声音

execute store result score #positional.animation.time.sound fca_store run data get entity @s data.transformation.sound

execute if score #positional.animation.time.sound fca_store = @s fca_timer run function fimel_anim_text:positional/animation/process/sound

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation