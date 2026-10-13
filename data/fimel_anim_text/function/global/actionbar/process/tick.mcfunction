# 副流程

execute if score #global.actionbar.timer fca_store matches ..-30 run return run function fimel_anim_text:global/actionbar/stop/style

# 主流程

execute if score #global.actionbar.timer fca_store matches 0 run function fimel_anim_text:global/actionbar/process/next

execute unless score #global.actionbar.timer fca_store matches 0 run scoreboard players remove #global.actionbar.timer fca_store 1