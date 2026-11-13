scoreboard players set #saved_die ma_ctx 0
execute store result score #saved_die ma_ctx run data get entity @s data.magical_athlete.dice
execute unless score #saved_die ma_ctx matches 1..6 run return 0
execute store result storage magical_athlete:visual die int 1 run scoreboard players get #saved_die ma_ctx
data modify storage magical_athlete:visual frame set value 12
function magical_athlete:visual/die_get with storage magical_athlete:visual
