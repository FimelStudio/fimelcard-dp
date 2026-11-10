scoreboard players set #decode dc_ctx 0
scoreboard players set #intercept dc_ctx 0
execute if score @s dc_role matches 2 run scoreboard players set #decode dc_ctx 1
execute if score @s dc_role matches 4 run scoreboard players set #decode dc_ctx 1
execute unless score @e[tag=dc.sync_controller,limit=1] dc_round matches 1 if score @s dc_role matches 3..4 run scoreboard players set #intercept dc_ctx 1
scoreboard players operation #duties dc_ctx = #decode dc_ctx
scoreboard players operation #duties dc_ctx += #intercept dc_ctx
