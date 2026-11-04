data modify storage splendor:direct hit set from entity @s data.hit
execute on target if entity @s[type=minecraft:player] run function splendor:direct/use with storage splendor:direct hit
data remove entity @s interaction
