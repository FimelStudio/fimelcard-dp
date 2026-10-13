# 识别速度

execute store result score #positional.animation.random fca_store run random value 1..2

# 专有数据

execute if score #positional.animation.random fca_store matches 1 run function fimel_anim_text:positional/animation/animation/24/specific1

execute if score #positional.animation.random fca_store matches 2 run function fimel_anim_text:positional/animation/animation/24/specific2