# 副流程

execute if score #global.title.timer fca_store matches ..-45 run return run function fimel_anim_text:global/title/stop/style

# 主流程

execute if score #global.title.timer fca_store matches 0 run function fimel_anim_text:global/title/process/next

execute unless score #global.title.timer fca_store matches 0 run scoreboard players remove #global.title.timer fca_store 1