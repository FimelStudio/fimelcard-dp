# 重置分数

scoreboard players set #local.actionbar.text fca_store 1

scoreboard players set #local.actionbar.sound fca_store 1

scoreboard players set #local.actionbar.speed_ fca_store 100

scoreboard players set #local.actionbar.style fca_store 0

scoreboard players set #local.actionbar.analyse fca_store 1

# 输入覆盖

execute if data storage fimel_anim_text:runtime local.actionbar.data.sound store result score #local.actionbar.sound fca_store run data get storage fimel_anim_text:runtime local.actionbar.data.sound

execute if data storage fimel_anim_text:runtime local.actionbar.data.speed store result score #local.actionbar.speed_ fca_store run data get storage fimel_anim_text:runtime local.actionbar.data.speed

execute if data storage fimel_anim_text:runtime local.actionbar.data.style store result score #local.actionbar.style fca_store run data get storage fimel_anim_text:runtime local.actionbar.data.style

execute if data storage fimel_anim_text:runtime local.actionbar.data.analyse store result score #local.actionbar.analyse fca_store run data get storage fimel_anim_text:runtime local.actionbar.data.analyse

# 重置命令

data modify storage fimel_anim_text:runtime local.actionbar.command set value ""

execute if data storage fimel_anim_text:runtime local.actionbar.data.command run data modify storage fimel_anim_text:runtime local.actionbar.command set from storage fimel_anim_text:runtime local.actionbar.data.command

# 设置速度参数

scoreboard players set #local.actionbar.speed fca_store 10000

scoreboard players operation #local.actionbar.speed fca_store /= #local.actionbar.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime local.actionbar.data.text run return run scoreboard players set #local.actionbar.text fca_store 0

# 文本预处理

execute if score #local.actionbar.analyse fca_store matches 0 run return run function fimel_anim_text:local/actionbar/start/analyse_test

function fimel_anim_text:local/actionbar/start/analyse