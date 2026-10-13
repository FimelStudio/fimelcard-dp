# 复制数据

data modify storage fimel_anim_text:runtime local.actionbar set from entity @s data

# 检测标签

execute if data storage fimel_anim_text:runtime local.actionbar{style:1} run function fimel_anim_text:local/actionbar/stop/style_1

execute if data storage fimel_anim_text:runtime local.actionbar{style:2} run function fimel_anim_text:local/actionbar/stop/style_2

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime local.actionbar