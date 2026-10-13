# 无结束动画

execute if data storage fimel_anim_text:runtime local.title{style:0} run return run function fimel_anim_text:local/title/stop/default

# 结束动画

scoreboard players set @s fca_timer -1