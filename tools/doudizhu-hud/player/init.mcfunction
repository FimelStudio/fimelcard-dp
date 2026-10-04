tag @s add dd.player
tag @s add dd.actor
scoreboard players operation @s dd_id = @s ct_id
scoreboard players operation @s dd_seat = @s ct_seat
scoreboard players set @s dd_plays 0
scoreboard players set @s dd_points 0
scoreboard players set @s dd_action 0
scoreboard players set @s dd_drop 0
scoreboard players enable @s dd_action
scoreboard players set @s dd_drop_dye 0
function doudizhu:input/clear
