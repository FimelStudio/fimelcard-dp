# 重置分数

scoreboard players set #global.title.replace fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime global.title.data.replace store result score #global.title.replace fca_store run data get storage fimel_anim_text:runtime global.title.data.replace