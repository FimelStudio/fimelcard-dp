# 判断掉落

execute if entity @s[tag=fimel.anim_text.positional.animation.drop] run return run function fimel_anim_text:positional/animation/process/drop/main

# 加分

scoreboard players add @s fca_timer 1

execute if score @s fca_timer > @s fca_timer_max run return run function fimel_anim_text:positional/animation/process/text_out/out

# 检索样式

execute if score @s fca_timer < @s fca_timer_start run return fail

scoreboard players operation #positional.animation.style fca_store = @s fca_style

function fimel_anim_text:positional/animation/process/animation/index