# 识别速度

execute if score #positional.animation.speed fca_store matches ..99 run function fimel_anim_text:positional/animation/animation/15/transformation/fast

execute if score #positional.animation.speed fca_store matches 100.. run function fimel_anim_text:positional/animation/animation/15/transformation/slow

function fimel_anim_text:positional/animation/animation/15/transformation/opacity