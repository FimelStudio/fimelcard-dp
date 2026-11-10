scoreboard players operation @s dc_gp = #guess_phase dc_ctx
scoreboard players operation @s dc_gr = @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_round
scoreboard players set @s dc_g1 0
scoreboard players set @s dc_g2 0
scoreboard players set @s dc_g3 0
execute unless score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_pos matches 2.. run scoreboard players operation @s dc_g1 = @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_guess1
execute unless score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_pos matches 3.. run scoreboard players operation @s dc_g2 = @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_guess2
