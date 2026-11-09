function catan:direct/read_hand with storage catan:direct
clear @s minecraft:oak_log[minecraft:custom_data~{catan:{resource:1b}}]
clear @s minecraft:brick[minecraft:custom_data~{catan:{resource:1b}}]
clear @s minecraft:white_wool[minecraft:custom_data~{catan:{resource:1b}}]
clear @s minecraft:wheat[minecraft:custom_data~{catan:{resource:1b}}]
clear @s minecraft:iron_ingot[minecraft:custom_data~{catan:{resource:1b}}]
execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[0]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/resource_inventory {id:0,name:"木材",model:"card:catan/hand/resource/wood"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[1]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/resource_inventory {id:1,name:"砖块",model:"card:catan/hand/resource/brick"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[2]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/resource_inventory {id:2,name:"羊毛",model:"card:catan/hand/resource/wool"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[3]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/resource_inventory {id:3,name:"粮食",model:"card:catan/hand/resource/grain"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[4]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/resource_inventory {id:4,name:"矿石",model:"card:catan/hand/resource/ore"}
