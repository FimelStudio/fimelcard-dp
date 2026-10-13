data modify storage fimel_anim_text:runtime positional.animation.text set from storage fimel_anim_text:runtime positional.animation.input[0]

data remove storage fimel_anim_text:runtime positional.animation.input[0]

# 速度

execute store result score #positional.animation.speed fca_store run data get storage fimel_anim_text:runtime positional.animation.speed

scoreboard players set #positional.animation.timer fca_store 2

# 检测delay

execute if data storage fimel_anim_text:runtime positional.animation.text.delay store result score #positional.animation.timer fca_store run data get storage fimel_anim_text:runtime positional.animation.text.delay

scoreboard players operation #positional.animation.timer fca_store *= #positional.animation.speed fca_store

scoreboard players operation #positional.animation.timer fca_store /= #value.100 fca_store

scoreboard players operation @s fca_timer = #positional.animation.timer fca_store