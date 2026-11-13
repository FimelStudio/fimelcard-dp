function aeroplane_chess:system/context
scoreboard players set @s ac_state 0
scoreboard players set @e[tag=ac.board] ac_legal 0
scoreboard players add @s ac_epoch 1
data modify entity @s data.aeroplane_chess.review set value 1b
data remove entity @s data.aeroplane_chess.queue
function aeroplane_chess:visual/refresh
title @a[tag=ac.audience] actionbar {text:""}
execute as @a[tag=ac.player] if score @s ac_table = #table ac_ctx run function aeroplane_chess:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run function aeroplane_chess:player/kill_drop
function cardtable:game/return_lobby
