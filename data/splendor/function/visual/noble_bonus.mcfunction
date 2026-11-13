function splendor:visual/arriving_noble
data modify storage splendor:visual id set value 1
function splendor:visual/spawn
execute at @s run particle minecraft:happy_villager ~ ~1.4 ~ .30 .12 .30 .03 15 force
