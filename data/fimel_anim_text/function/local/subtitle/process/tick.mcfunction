# 跳出

execute unless data entity @s data{replace:2} if score #global.subtitle.print fca_store matches 1 run return fail

# 副流程

execute if score @s fca_timer matches ..-30 run return run function fimel_anim_text:local/subtitle/stop/style

# 主流程

execute if score @s fca_timer matches 0 run function fimel_anim_text:local/subtitle/process/next

execute unless score @s fca_timer matches 0 run scoreboard players remove @s fca_timer 1