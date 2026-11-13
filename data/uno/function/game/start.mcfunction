function uno:game/init_table
function uno:log {text:"检查开局人数、在线状态及第一格快捷栏"}
execute unless score @s ct_joined matches 2..8 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 需要 2～8 名玩家。',color:'red'}]
execute unless score @s ct_joined matches 2..8 run return fail
execute if score @s ct_joined > @s ct_capacity run return fail
scoreboard players operation #table un_ctx = @s ct_id
scoreboard players set #u_online un_ctx 0
scoreboard players set #u_blocked un_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx run scoreboard players add #u_online un_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}] run scoreboard players set #u_blocked un_ctx 1
execute unless score #u_online un_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 有已入座的玩家不在线。',color:'red'}]
execute unless score #u_online un_ctx = @s ct_joined run return fail
execute if score #u_blocked un_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 请所有玩家先清空快捷栏第一格。',color:'red'}]
execute if score #u_blocked un_ctx matches 1 run return fail
tag @s add un.controller
scoreboard players operation @s un_size = @s ct_joined
scoreboard players set @s un_round 0
scoreboard players set @s un_clock 0
scoreboard players set @s un_matchend 0
execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx run function uno:player/init
function uno:system/context
execute as @a[tag=un.audience] run function cardtable:seat/mount
execute as @a[tag=un.audience] run function uno:input/give
scoreboard players set @s ct_start 1
function uno:round/start
