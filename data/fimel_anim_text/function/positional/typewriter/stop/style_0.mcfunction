# 淡化动画编码

execute if score @s fca_timer matches -40 run return run function fimel_anim_text:positional/typewriter/stop/style_0_calc

execute if score @s fca_timer matches -55..-41 run function fimel_anim_text:positional/typewriter/stop/style_0_fade

execute if score @s fca_timer matches -55 run return run function fimel_anim_text:positional/typewriter/stop/default