# 副流程

execute if score @s fca_timer matches ..-40 run function fimel_anim_text:positional/typewriter/stop/style

# 主流程

execute if score @s fca_timer matches 0 run function fimel_anim_text:positional/typewriter/process/next

execute unless score @s fca_timer matches 0 run scoreboard players remove @s fca_timer 1