execute store result storage catan:direct side int 1 run scoreboard players get @s ca_side
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
function catan:direct/read_hand with storage catan:direct
execute store result score #res ca_ctx run data get storage catan:direct hand.resources[0]
execute store result storage catan:direct count int 1 run scoreboard players get #res ca_ctx
data modify storage catan:direct item set value "oak_log"
function catan:direct/sync_resource with storage catan:direct
execute store result score #res ca_ctx run data get storage catan:direct hand.resources[1]
execute store result storage catan:direct count int 1 run scoreboard players get #res ca_ctx
data modify storage catan:direct item set value "brick"
function catan:direct/sync_resource with storage catan:direct
execute store result score #res ca_ctx run data get storage catan:direct hand.resources[2]
execute store result storage catan:direct count int 1 run scoreboard players get #res ca_ctx
data modify storage catan:direct item set value "white_wool"
function catan:direct/sync_resource with storage catan:direct
execute store result score #res ca_ctx run data get storage catan:direct hand.resources[3]
execute store result storage catan:direct count int 1 run scoreboard players get #res ca_ctx
data modify storage catan:direct item set value "wheat"
function catan:direct/sync_resource with storage catan:direct
execute store result score #res ca_ctx run data get storage catan:direct hand.resources[4]
execute store result storage catan:direct count int 1 run scoreboard players get #res ca_ctx
data modify storage catan:direct item set value "iron_ingot"
function catan:direct/sync_resource with storage catan:direct
scoreboard players operation @s ca_inv_epoch = @e[tag=ca.current,limit=1] ca_epoch
