dialog clear @s
function doudizhu:hud/deactivate
function doudizhu:input/clear
tag @s remove dd.player
tag @s remove dd.actor
tag @s remove dd.actors
tag @s remove dd.audience
scoreboard players reset @s dd_id
scoreboard players reset @s dd_seat
scoreboard players reset @s dd_plays
scoreboard players reset @s dd_count
scoreboard players reset @s dd_points
scoreboard players reset @s dd_total
scoreboard players reset @s dd_action
scoreboard players reset @s dd_drop

scoreboard players reset @s dd_drop_dye
