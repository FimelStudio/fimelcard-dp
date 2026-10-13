execute unless score @s fca_timer_total <= @s fca_timer run return fail

# 检索样式

scoreboard players operation #positional.animation.style fca_store = @s fca_style

function fimel_anim_text:positional/animation/process/text_out/index