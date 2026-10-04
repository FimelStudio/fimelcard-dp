tag @s add dd.player
scoreboard players operation @s dd_id = @s ct_id
scoreboard players operation @s dd_seat = @s ct_seat
scoreboard players set @s dd_plays 0
scoreboard players set @s dd_points 0
scoreboard players set @s dd_action 0
scoreboard players set @s dd_drop 0
scoreboard players enable @s dd_action
function doudizhu:input/give
