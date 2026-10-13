# 重置分数

scoreboard players set #local.title.replace fca_store 0

scoreboard players set #local.title.print fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime local.title.data.replace store result score #local.title.replace fca_store run data get storage fimel_anim_text:runtime local.title.data.replace

execute if score #local.title.replace fca_store matches 2.. run tag @s add fimel.anim_text.replace.title

# 检测标签

execute if entity @s[tag=fimel.anim_text.local.title] run scoreboard players set #local.title.print fca_store 1