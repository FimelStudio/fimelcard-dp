data modify storage magical_athlete:direct hit set from entity @s data.hit
execute on target if entity @s[type=minecraft:player] run function magical_athlete:direct/use with storage magical_athlete:direct hit
data remove entity @s interaction
