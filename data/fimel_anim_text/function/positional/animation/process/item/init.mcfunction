# 添加标签

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.positional

tag @s add fimel.anim_text.positional.animation

tag @s remove fimel.anim_text.positional.animation.temp

# 计算初速度

data modify storage fimel_anim_text:runtime operation.drop.input set from storage fimel_anim_text:runtime positional.animation.drop

function fimel_anim_text:operation/drop/start

data modify entity @s Motion set from storage fimel_anim_text:runtime operation.drop.output

# 设置billboard

execute if data storage fimel_anim_text:runtime operation.drop.input.billboard on passengers run function fimel_anim_text:positional/animation/process/drop/billboard