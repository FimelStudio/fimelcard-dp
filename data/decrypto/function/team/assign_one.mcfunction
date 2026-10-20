scoreboard players add #order dc_ctx 1
scoreboard players set @s dc_team 2
execute if score #order dc_ctx <= #white_size dc_ctx run scoreboard players set @s dc_team 1

tag @s remove dc.team_pool
