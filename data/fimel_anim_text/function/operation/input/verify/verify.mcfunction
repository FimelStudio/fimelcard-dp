# 复制复合标签

data modify storage fimel_anim_text:runtime operation.text.text set from storage fimel_anim_text:runtime operation.text.copy[0]

# 删除第一位

data remove storage fimel_anim_text:runtime operation.text.copy[0]

# 补全颜色与字体 防止转回字符串

execute unless data storage fimel_anim_text:runtime operation.text.text.color run data modify storage fimel_anim_text:runtime operation.text.text.color set value "white"

execute unless data storage fimel_anim_text:runtime operation.text.text.italic run data modify storage fimel_anim_text:runtime operation.text.text.italic set value false

# 筛选组件

data modify entity @s text set value ""

data modify entity @s text set from storage fimel_anim_text:runtime operation.text.text

# 找回sound delay

execute unless data entity @s {text:""} run data modify storage fimel_anim_text:runtime operation.text.next set from entity @s text

execute if data storage fimel_anim_text:runtime operation.text.text.sound run data modify storage fimel_anim_text:runtime operation.text.next.sound set from storage fimel_anim_text:runtime operation.text.text.sound
execute if data storage fimel_anim_text:runtime operation.text.text.delay run data modify storage fimel_anim_text:runtime operation.text.next.delay set from storage fimel_anim_text:runtime operation.text.text.delay

# 插入组件

execute unless data entity @s {text:""} run data modify storage fimel_anim_text:runtime operation.text.output append from storage fimel_anim_text:runtime operation.text.next

data modify storage fimel_anim_text:runtime operation.text.copy_0 append from storage fimel_anim_text:runtime operation.text.next

# 递归

execute unless data storage fimel_anim_text:runtime operation.text.copy[0] run return run kill @s

function fimel_anim_text:operation/input/verify/verify