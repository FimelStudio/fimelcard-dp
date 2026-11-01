tag @e[tag=it.drop] remove it.drop
tag @s add it.drop
execute on origin if entity @s[tag=it.player] at @s run function ito:input/from_player
kill @s
