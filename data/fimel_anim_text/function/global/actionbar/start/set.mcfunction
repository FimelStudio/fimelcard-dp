# 重置分数

scoreboard players set #global.actionbar.text fca_store 1

scoreboard players set #global.actionbar.timer fca_store 0

scoreboard players set #global.actionbar.sound fca_store 1

scoreboard players set #global.actionbar.speed_ fca_store 100

scoreboard players set #global.actionbar.style fca_store 0

scoreboard players set #global.actionbar.analyse fca_store 1

# 输入覆盖

execute if data storage fimel_anim_text:runtime global.actionbar.data.sound store result score #global.actionbar.sound fca_store run data get storage fimel_anim_text:runtime global.actionbar.data.sound

execute if data storage fimel_anim_text:runtime global.actionbar.data.speed store result score #global.actionbar.speed_ fca_store run data get storage fimel_anim_text:runtime global.actionbar.data.speed

execute if data storage fimel_anim_text:runtime global.actionbar.data.style store result score #global.actionbar.style fca_store run data get storage fimel_anim_text:runtime global.actionbar.data.style

execute if data storage fimel_anim_text:runtime global.actionbar.data.analyse store result score #global.actionbar.analyse fca_store run data get storage fimel_anim_text:runtime global.actionbar.data.analyse

# 重置命令

data modify storage fimel_anim_text:runtime global.actionbar.command set value ""

execute if data storage fimel_anim_text:runtime global.actionbar.data.command run data modify storage fimel_anim_text:runtime global.actionbar.command set from storage fimel_anim_text:runtime global.actionbar.data.command

# 设置速度参数

scoreboard players set #global.actionbar.speed fca_store 10000

scoreboard players operation #global.actionbar.speed fca_store /= #global.actionbar.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime global.actionbar.data.text run return run scoreboard players set #global.actionbar.text fca_store 0

# 文本预处理

execute if score #global.actionbar.analyse fca_store matches 0 run return run function fimel_anim_text:global/actionbar/start/analyse_test

function fimel_anim_text:global/actionbar/start/analyse