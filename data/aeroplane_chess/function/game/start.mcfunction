function aeroplane_chess:game/init_table
execute unless score @s ct_joined matches 1..4 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[飞行棋] 支持 1～4 位玩家；单人开局需开启电脑补位。", "color": "red"}
execute unless score @s ct_joined matches 1..4 run return fail
execute if score @s ct_joined matches 1 if score @s ac_fill matches 2 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[飞行棋] 电脑补位已关闭，请至少两位玩家入座，或在设置中开启电脑。", "color": "red"}
execute if score @s ct_joined matches 1 if score @s ac_fill matches 2 run return fail
function aeroplane_chess:system/context
scoreboard players set #online ac_ctx 0
scoreboard players set #blocked ac_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx run scoreboard players add #online ac_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run scoreboard players set #blocked ac_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run scoreboard players set #blocked ac_ctx 1
execute unless score #online ac_ctx = @s ct_joined run return fail
execute if score #blocked ac_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[飞行棋] 请先清空快捷栏第 1 格和最后一格。", "color": "red"}
execute if score #blocked ac_ctx matches 1 run return fail
function aeroplane_chess:settings/invalidate_table
function aeroplane_chess:engine/init_board
scoreboard players set @e[tag=ac.sides] ac_active 0
scoreboard players set @e[tag=ac.sides] ac_bot 0
scoreboard players set @s ac_players 0
scoreboard players set @s ac_ranked 0
scoreboard players set @s ac_finished 0
scoreboard players set @s ac_winner -1
execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx run function aeroplane_chess:player/init
function aeroplane_chess:system/context
function aeroplane_chess:game/fill_bots
function aeroplane_chess:game/sync_active
function aeroplane_chess:game/reseat
data remove entity @s data.aeroplane_chess.review
data remove entity @s data.aeroplane_chess.queue
scoreboard players set @s ac_state 1
scoreboard players set @s ac_sixes 0
scoreboard players set @s ac_selected -1
scoreboard players set @s ac_wait 10
scoreboard players set @s ac_pulse 0
scoreboard players add @s ac_epoch 1
function aeroplane_chess:game/first_turn
function aeroplane_chess:visual/setup
execute as @a[tag=ac.audience] run function aeroplane_chess:input/give
scoreboard players set @s ct_start 1
function aeroplane_chess:ui/refresh
function aeroplane_chess:sound/start
tellraw @a[tag=ac.audience] {"text": "[飞行棋] 对局开始。第 1 格按 Q 投骰，骰子停稳后右键飞机。", "color": "yellow"}
