scoreboard players set #owner ca_ctx 0
execute on origin if entity @s[tag=ca.dropper] run scoreboard players set #owner ca_ctx 1
execute unless score #owner ca_ctx matches 1 run return 0
data modify storage catan:input drop set from entity @s Item.components."minecraft:custom_data".catan
function catan:input/use_drop with storage catan:input drop
kill @s
