# 无结束动画

execute if score #global.subtitle.style fca_store matches 0 run return run function fimel_anim_text:global/subtitle/stop/default

# 结束动画

scoreboard players set #global.subtitle.timer fca_store -1