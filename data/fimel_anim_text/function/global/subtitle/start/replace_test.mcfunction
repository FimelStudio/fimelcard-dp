# 重置分数

scoreboard players set #global.subtitle.replace fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime global.subtitle.data.replace store result score #global.subtitle.replace fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.replace