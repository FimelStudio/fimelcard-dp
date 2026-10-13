# 重置分数

scoreboard players set #global.subtitle.text fca_store 1

scoreboard players set #global.subtitle.timer fca_store 0

scoreboard players set #global.subtitle.sound fca_store 1

scoreboard players set #global.subtitle.speed_ fca_store 100

scoreboard players set #global.subtitle.style fca_store 0

scoreboard players set #global.subtitle.analyse fca_store 1

scoreboard players set #global.subtitle.title fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime global.subtitle.data.sound store result score #global.subtitle.sound fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.sound

execute if data storage fimel_anim_text:runtime global.subtitle.data.speed store result score #global.subtitle.speed_ fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.speed

execute if data storage fimel_anim_text:runtime global.subtitle.data.style store result score #global.subtitle.style fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.style

execute if data storage fimel_anim_text:runtime global.subtitle.data.analyse store result score #global.subtitle.analyse fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.analyse

execute if data storage fimel_anim_text:runtime global.subtitle.data.title store result score #global.subtitle.title fca_store run data get storage fimel_anim_text:runtime global.subtitle.data.title

# 重置命令

data modify storage fimel_anim_text:runtime global.subtitle.command set value ""

execute if data storage fimel_anim_text:runtime global.subtitle.data.command run data modify storage fimel_anim_text:runtime global.subtitle.command set from storage fimel_anim_text:runtime global.subtitle.data.command

# 设置速度参数

scoreboard players set #global.subtitle.speed fca_store 10000

scoreboard players operation #global.subtitle.speed fca_store /= #global.subtitle.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime global.subtitle.data.text run return run scoreboard players set #global.subtitle.text fca_store 0

# 文本预处理

execute if score #global.subtitle.analyse fca_store matches 0 run return run function fimel_anim_text:global/subtitle/start/analyse_test

function fimel_anim_text:global/subtitle/start/analyse