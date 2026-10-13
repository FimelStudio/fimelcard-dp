# 重置分数

scoreboard players set #local.subtitle.text fca_store 1

scoreboard players set #local.subtitle.sound fca_store 1

scoreboard players set #local.subtitle.speed_ fca_store 100

scoreboard players set #local.subtitle.style fca_store 0

scoreboard players set #local.subtitle.analyse fca_store 1

scoreboard players set #local.subtitle.title fca_store 0

# 输入覆盖

execute if data storage fimel_anim_text:runtime local.subtitle.data.sound store result score #local.subtitle.sound fca_store run data get storage fimel_anim_text:runtime local.subtitle.data.sound

execute if data storage fimel_anim_text:runtime local.subtitle.data.speed store result score #local.subtitle.speed_ fca_store run data get storage fimel_anim_text:runtime local.subtitle.data.speed

execute if data storage fimel_anim_text:runtime local.subtitle.data.style store result score #local.subtitle.style fca_store run data get storage fimel_anim_text:runtime local.subtitle.data.style

execute if data storage fimel_anim_text:runtime local.subtitle.data.analyse store result score #local.subtitle.analyse fca_store run data get storage fimel_anim_text:runtime local.subtitle.data.analyse

execute if data storage fimel_anim_text:runtime local.subtitle.data.title store result score #local.subtitle.title fca_store run data get storage fimel_anim_text:runtime local.subtitle.data.title

# 重置命令

data modify storage fimel_anim_text:runtime local.subtitle.command set value ""

execute if data storage fimel_anim_text:runtime local.subtitle.data.command run data modify storage fimel_anim_text:runtime local.subtitle.command set from storage fimel_anim_text:runtime local.subtitle.data.command

# 设置速度参数

scoreboard players set #local.subtitle.speed fca_store 10000

scoreboard players operation #local.subtitle.speed fca_store /= #local.subtitle.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime local.subtitle.data.text run return run scoreboard players set #local.subtitle.text fca_store 0

# 文本预处理

execute if score #local.subtitle.analyse fca_store matches 0 run return run function fimel_anim_text:local/subtitle/start/analyse_test

function fimel_anim_text:local/subtitle/start/analyse