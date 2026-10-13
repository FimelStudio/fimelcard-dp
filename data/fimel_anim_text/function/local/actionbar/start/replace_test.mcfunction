# 重置分数

scoreboard players set #local.actionbar.replace fca_store 0

scoreboard players set #local.actionbar.print fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime local.actionbar.data.replace store result score #local.actionbar.replace fca_store run data get storage fimel_anim_text:runtime local.actionbar.data.replace

execute if score #local.actionbar.replace fca_store matches 2.. run tag @s add fimel.anim_text.replace.actionbar

# 检测标签

execute if entity @s[tag=fimel.anim_text.local.actionbar] run scoreboard players set #local.actionbar.print fca_store 1