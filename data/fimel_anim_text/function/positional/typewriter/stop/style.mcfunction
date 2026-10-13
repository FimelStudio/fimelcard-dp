# 复制数据

data modify storage fimel_anim_text:runtime positional.typewriter set from entity @s data

# 检测标签

execute if data storage fimel_anim_text:runtime positional.typewriter{style:0} run return run function fimel_anim_text:positional/typewriter/stop/style_0

execute if data storage fimel_anim_text:runtime positional.typewriter{style:1} run function fimel_anim_text:positional/typewriter/stop/style_1

execute if data storage fimel_anim_text:runtime positional.typewriter{style:2} run function fimel_anim_text:positional/typewriter/stop/style_2

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.typewriter