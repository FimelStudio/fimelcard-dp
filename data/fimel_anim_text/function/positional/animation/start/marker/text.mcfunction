data modify storage fimel_anim_text:runtime positional.animation.text set from storage fimel_anim_text:runtime positional.animation.input[0]

data remove storage fimel_anim_text:runtime positional.animation.input[0]

# 计算分数

function fimel_anim_text:positional/animation/start/marker/amount