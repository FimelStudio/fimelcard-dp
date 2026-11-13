execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @s dc_team matches 1 if data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.white.clues run return 0
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @s dc_team matches 2 if data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.black.clues run return 0
execute unless score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_state matches 2 unless score @s dc_team matches 1 run return 0
execute unless score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_state matches 4 unless score @s dc_team matches 2 run return 0
scoreboard players set #hint dc_ctx 3
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_input matches 1 run scoreboard players set #hint dc_ctx 4
