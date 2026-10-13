# 无结束动画

execute if score #global.title.style fca_store matches 0 run return run function fimel_anim_text:global/title/stop/default

# 结束动画

scoreboard players set #global.title.timer fca_store -1