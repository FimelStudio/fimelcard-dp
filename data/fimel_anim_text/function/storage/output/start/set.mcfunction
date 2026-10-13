# 重置分数

scoreboard players set #storage.output.text fca_store 1

scoreboard players set #storage.output.sound fca_store 1

scoreboard players set #storage.output.speed_ fca_store 100

scoreboard players set #storage.output.style fca_store 0

scoreboard players set #storage.output.analyse fca_store 1

# 输入覆盖

execute if data storage fimel_anim_text:runtime storage.output.data.data.sound store result score #storage.output.data.sound fca_store run data get storage fimel_anim_text:runtime storage.output.data.data.sound

execute if data storage fimel_anim_text:runtime storage.output.data.data.speed store result score #storage.output.data.speed_ fca_store run data get storage fimel_anim_text:runtime storage.output.data.data.speed

execute if data storage fimel_anim_text:runtime storage.output.data.data.style store result score #storage.output.data.style fca_store run data get storage fimel_anim_text:runtime storage.output.data.data.style

execute if data storage fimel_anim_text:runtime storage.output.data.data.analyse store result score #storage.output.data.analyse fca_store run data get storage fimel_anim_text:runtime storage.output.data.data.analyse

# 重置命令

data modify storage fimel_anim_text:runtime storage.output.data.command set value ""

execute if data storage fimel_anim_text:runtime storage.output.data.data.command run data modify storage fimel_anim_text:runtime storage.output.data.command set from storage fimel_anim_text:runtime storage.output.data.data.command

# 重置id

data modify storage fimel_anim_text:runtime storage.output.data.id set value ""

execute if data storage fimel_anim_text:runtime storage.output.data.data.id run data modify storage fimel_anim_text:runtime storage.output.data.id set from storage fimel_anim_text:runtime storage.output.data.data.id

# 设置速度参数

scoreboard players set #storage.output.speed fca_store 10000

scoreboard players operation #storage.output.speed fca_store /= #storage.output.speed_ fca_store

# 文本检测

execute unless data storage fimel_anim_text:runtime storage.output.data.data.text run return run scoreboard players set #storage.output.text fca_store 0

# 文本预处理

execute if score #storage.output.analyse fca_store matches 0 run return run function fimel_anim_text:storage/output/start/analyse_test

function fimel_anim_text:storage/output/start/analyse