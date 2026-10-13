# 副流程

execute if score @s fca_timer matches ..-30 run return run function fimel_anim_text:storage/output/stop/style

# 主流程

execute if score @s fca_timer matches 0 run function fimel_anim_text:storage/output/process/next

execute unless score @s fca_timer matches 0 run scoreboard players remove @s fca_timer 1