# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 掉落跳出

execute if data storage fimel_anim_text:runtime positional.animation.drop run return run function fimel_anim_text:positional/animation/process/drop

# 检测标签

execute unless entity @s[tag=fimel.anim_text.positional.animation.obfuscasted] run function fimel_anim_text:positional/animation/animation/26/obf

# 动画

execute store result score #positional.animation.fade.opacity fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.out.value

execute store result score #positional.animation.fade.step fca_store run data get storage fimel_anim_text:runtime positional.animation.transformation.out.step

scoreboard players operation #positional.animation.fade.opacity fca_store -= #positional.animation.fade.step fca_store

execute store result entity @s text_opacity byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store

execute store result storage fimel_anim_text:runtime positional.animation.transformation.out.value byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store

execute if score #positional.animation.fade.opacity fca_store matches 0..15 run return run function fimel_anim_text:positional/animation/animation/0/kill

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation