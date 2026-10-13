
# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 动画

execute store result score #positional.animation.fade.opacity fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.out_1.value

execute store result score #positional.animation.fade.step fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.out_1.step

scoreboard players operation #positional.animation.fade.opacity fca_store += #positional.animation.fade.step fca_store

execute store result entity @s text_opacity byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store

execute store result storage fimel_anim_text:runtime positional.animation.transformation.out_1.value byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store

# 声音

execute store result score #positional.animation.time.sound fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.sound

execute if score #positional.animation.time.sound fca_store = @s fca_timer run function fimel_anim_text:positional/animation/process/sound

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation