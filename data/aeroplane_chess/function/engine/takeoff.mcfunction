scoreboard players set #allowed ac_ctx 0
execute if score #dice ac_ctx matches 6 run scoreboard players set #allowed ac_ctx 1
execute if score @s ac_takeoff matches 1 if score #dice ac_ctx matches 5 run scoreboard players set #allowed ac_ctx 1
execute if score @s ac_takeoff matches 2 run scoreboard players set #allowed ac_ctx 1
execute unless score #allowed ac_ctx matches 1 run return 0
data modify storage aeroplane_chess:runtime plan.queue set value [{pos:0,kind:1,land:1}]
scoreboard players set #dest ac_ctx 0
scoreboard players set #legal ac_ctx 1
