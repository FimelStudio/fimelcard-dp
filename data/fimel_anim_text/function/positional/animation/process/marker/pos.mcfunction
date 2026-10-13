# 复制数据

data modify storage fimel_anim_text:runtime positional.animation set from entity @s data

# 检测反向

execute store result score #positional.animation.reverse fca_store run data get storage fimel_anim_text:runtime positional.animation.reverse

execute if score #positional.animation.reverse fca_store matches 0 run function fimel_anim_text:positional/animation/process/marker/pos1 with storage fimel_anim_text:runtime positional.animation.shift

execute if score #positional.animation.reverse fca_store matches 1 run function fimel_anim_text:positional/animation/process/marker/pos2 with storage fimel_anim_text:runtime positional.animation.shift

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation