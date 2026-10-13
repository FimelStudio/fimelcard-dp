# 检测反向

execute if score #positional.animation.reverse fca_store matches 0 run function fimel_anim_text:positional/animation/start/marker/pos1 with storage fimel_anim_text:runtime positional.animation.shift

execute if score #positional.animation.reverse fca_store matches 1 run function fimel_anim_text:positional/animation/start/marker/pos2 with storage fimel_anim_text:runtime positional.animation.shift