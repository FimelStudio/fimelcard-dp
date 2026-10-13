# 重置分数

scoreboard players set #global.title.text fca_store 1

scoreboard players set #global.title.timer fca_store 0

scoreboard players set #global.title.sound fca_store 1

scoreboard players set #global.title.speed_ fca_store 100

scoreboard players set #global.title.style fca_store 0

scoreboard players set #global.title.analyse fca_store 1

# 输入覆盖

execute if data storage fimel_anim_text:runtime global.title.data.sound store result score #global.title.sound fca_store run data get storage fimel_anim_text:runtime global.title.data.sound

execute if data storage fimel_anim_text:runtime global.title.data.speed store result score #global.title.speed_ fca_store run data get storage fimel_anim_text:runtime global.title.data.speed

execute if data storage fimel_anim_text:runtime global.title.data.style store result score #global.title.style fca_store run data get storage fimel_anim_text:runtime global.title.data.style

execute if data storage fimel_anim_text:runtime global.title.data.analyse store result score #global.title.analyse fca_store run data get storage fimel_anim_text:runtime global.title.data.analyse

# 重置命令

data modify storage fimel_anim_text:runtime global.title.command set value ""

execute if data storage fimel_anim_text:runtime global.title.data.command run data modify storage fimel_anim_text:runtime global.title.command set from storage fimel_anim_text:runtime global.title.data.command

# 设置速度参数

scoreboard players set #global.title.speed fca_store 10000

scoreboard players operation #global.title.speed fca_store /= #global.title.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime global.title.data.text run return run scoreboard players set #global.title.text fca_store 0

# 文本预处理

execute if score #global.title.analyse fca_store matches 0 run return run function fimel_anim_text:global/title/start/analyse_test

function fimel_anim_text:global/title/start/analyse