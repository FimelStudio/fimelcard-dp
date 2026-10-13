# 副流程

execute if score #global.subtitle.timer fca_store matches ..-45 run return run function fimel_anim_text:global/subtitle/stop/style

# 主流程

execute if score #global.subtitle.timer fca_store matches 0 run function fimel_anim_text:global/subtitle/process/next

execute unless score #global.subtitle.timer fca_store matches 0 run scoreboard players remove #global.subtitle.timer fca_store 1