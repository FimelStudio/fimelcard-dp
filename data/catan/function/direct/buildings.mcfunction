execute store result storage catan:direct side int 1 run scoreboard players get @s ca_side
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
function catan:direct/read_hand with storage catan:direct
data modify storage catan:direct color set value "red"
execute if score @s ca_side matches 1 run data modify storage catan:direct color set value "red"
execute if score @s ca_side matches 2 run data modify storage catan:direct color set value "blue"
execute if score @s ca_side matches 3 run data modify storage catan:direct color set value "white"
execute if score @s ca_side matches 4 run data modify storage catan:direct color set value "orange"
execute store result score #r0 ca_ctx run data get storage catan:direct hand.resources[0]
execute store result score #r1 ca_ctx run data get storage catan:direct hand.resources[1]
execute store result score #r2 ca_ctx run data get storage catan:direct hand.resources[2]
execute store result score #r3 ca_ctx run data get storage catan:direct hand.resources[3]
execute store result score #r4 ca_ctx run data get storage catan:direct hand.resources[4]
data modify storage catan:direct kind set value "settlement"
data modify storage catan:direct slot set value 0
data modify storage catan:direct mode set value 2
scoreboard players set #afford ca_ctx 1
execute unless score #r0 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute unless score #r1 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute unless score #r2 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute unless score #r3 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run scoreboard players set #afford ca_ctx 1
execute if score #afford ca_ctx matches 1 run function catan:direct/build_item with storage catan:direct
execute if score #afford ca_ctx matches 0 run function catan:direct/build_gray with storage catan:direct
data modify storage catan:direct kind set value "road"
data modify storage catan:direct slot set value 1
data modify storage catan:direct mode set value 3
scoreboard players set #afford ca_ctx 1
execute unless score #r0 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute unless score #r1 ca_ctx matches 1.. run scoreboard players set #afford ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run scoreboard players set #afford ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set #afford ca_ctx 1
execute if score #afford ca_ctx matches 1 run function catan:direct/build_item with storage catan:direct
execute if score #afford ca_ctx matches 0 run function catan:direct/build_gray with storage catan:direct
data modify storage catan:direct kind set value "city"
data modify storage catan:direct slot set value 2
data modify storage catan:direct mode set value 4
scoreboard players set #afford ca_ctx 1
execute unless score #r3 ca_ctx matches 2.. run scoreboard players set #afford ca_ctx 0
execute unless score #r4 ca_ctx matches 3.. run scoreboard players set #afford ca_ctx 0
execute if score #afford ca_ctx matches 1 run function catan:direct/build_item with storage catan:direct
execute if score #afford ca_ctx matches 0 run function catan:direct/build_gray with storage catan:direct
execute unless items entity @s hotbar.6 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:29}}] run function catan:direct/end_item with storage catan:direct
