# 无结束动画

execute if score #global.actionbar.style fca_store matches 0 run return run function fimel_anim_text:global/actionbar/stop/default

# 结束动画

scoreboard players set #global.actionbar.timer fca_store -1