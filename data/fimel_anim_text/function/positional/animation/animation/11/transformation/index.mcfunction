# 识别速度

execute if score #positional.animation.speed fca_store matches ..99 run function fimel_anim_text:positional/animation/animation/11/transformation/fast

execute if score #positional.animation.speed fca_store matches 100.. run function fimel_anim_text:positional/animation/animation/11/transformation/slow

function fimel_anim_text:positional/animation/animation/11/transformation/opacity