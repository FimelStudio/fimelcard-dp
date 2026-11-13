scoreboard players set @s dd_team 1
execute if score @s dd_seat matches 3..4 run scoreboard players set @s dd_team 2
execute if score @s dd_seat matches 7..8 run scoreboard players set @s dd_team 2
scoreboard players set #minus_one dd_ctx -1
execute if score @s dd_seat matches 2 run scoreboard players operation @s dd_id *= #minus_one dd_ctx
execute if score @s dd_seat matches 4 run scoreboard players operation @s dd_id *= #minus_one dd_ctx
execute if score @s dd_seat matches 6 run scoreboard players operation @s dd_id *= #minus_one dd_ctx
execute if score @s dd_seat matches 8 run scoreboard players operation @s dd_id *= #minus_one dd_ctx
