# 重置分数

scoreboard players set #positional.typewriter.text fca_store 1

scoreboard players set #positional.typewriter.sound fca_store 1

scoreboard players set #positional.typewriter.speed_ fca_store 100

scoreboard players set #positional.typewriter.style fca_store 0

scoreboard players set #positional.typewriter.analyse fca_store 1

scoreboard players set #positional.typewriter.width fca_store 32

# 输入覆盖

execute if data storage fimel_anim_text:runtime positional.typewriter.data.sound store result score #positional.typewriter.sound fca_store run data get storage fimel_anim_text:runtime positional.typewriter.data.sound

execute if data storage fimel_anim_text:runtime positional.typewriter.data.speed store result score #positional.typewriter.speed_ fca_store run data get storage fimel_anim_text:runtime positional.typewriter.data.speed

execute if data storage fimel_anim_text:runtime positional.typewriter.data.style store result score #positional.typewriter.style fca_store run data get storage fimel_anim_text:runtime positional.typewriter.data.style

execute if data storage fimel_anim_text:runtime positional.typewriter.data.analyse store result score #positional.typewriter.analyse fca_store run data get storage fimel_anim_text:runtime positional.typewriter.data.analyse

execute if data storage fimel_anim_text:runtime positional.typewriter.data.width store result score #positional.typewriter.width fca_store run data get storage fimel_anim_text:runtime positional.typewriter.data.width

# 重置参数

data modify storage fimel_anim_text:runtime positional.typewriter.command set value ""

execute if data storage fimel_anim_text:runtime positional.typewriter.data.command run data modify storage fimel_anim_text:runtime positional.typewriter.command set from storage fimel_anim_text:runtime positional.typewriter.data.command

data remove storage fimel_anim_text:runtime positional.typewriter.entity_properties

execute if data storage fimel_anim_text:runtime positional.typewriter.data.entity_properties run data modify storage fimel_anim_text:runtime positional.typewriter.entity_properties set from storage fimel_anim_text:runtime positional.typewriter.data.entity_properties

# 设置速度参数

scoreboard players set #positional.typewriter.speed fca_store 10000

scoreboard players operation #positional.typewriter.speed fca_store /= #positional.typewriter.speed_ fca_store

# 检测错误

execute unless score #positional.typewriter.speed fca_store matches 0.. run return fail

execute unless score #positional.typewriter.style fca_store matches 0..2 run return fail

# 文本检测

execute unless data storage fimel_anim_text:runtime positional.typewriter.data.text run return run scoreboard players set #positional.typewriter.text fca_store 0

# 文本预处理

execute if score #positional.typewriter.analyse fca_store matches 0 run return run function fimel_anim_text:positional/typewriter/start/analyse_test

function fimel_anim_text:positional/typewriter/start/analyse