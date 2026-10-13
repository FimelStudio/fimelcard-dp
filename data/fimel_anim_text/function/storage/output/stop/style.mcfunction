# 复制数据

data modify storage fimel_anim_text:runtime storage.output.data.data set from entity @s data

# 检测标签

execute if data storage fimel_anim_text:runtime storage.output.data{style:1} run function fimel_anim_text:storage/output/stop/style_1

execute if data storage fimel_anim_text:runtime storage.output.data{style:2} run function fimel_anim_text:storage/output/stop/style_2

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime storage.output.data