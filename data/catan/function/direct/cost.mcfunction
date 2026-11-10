function catan:direct/private
$data modify storage catan:direct cost set value $(cost)
$data modify storage catan:direct failure set value {text:{text:"$(label)材料不足：",color:"red",extra:[]}}
execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[0]
execute store result score #cost_need ca_ctx run data get storage catan:direct cost[0]
execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx
scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx
execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx
data modify storage catan:direct shortage.name set value "木材"
execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage
execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[1]
execute store result score #cost_need ca_ctx run data get storage catan:direct cost[1]
execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx
scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx
execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx
data modify storage catan:direct shortage.name set value "砖块"
execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage
execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[2]
execute store result score #cost_need ca_ctx run data get storage catan:direct cost[2]
execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx
scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx
execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx
data modify storage catan:direct shortage.name set value "羊毛"
execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage
execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[3]
execute store result score #cost_need ca_ctx run data get storage catan:direct cost[3]
execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx
scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx
execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx
data modify storage catan:direct shortage.name set value "粮食"
execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage
execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[4]
execute store result score #cost_need ca_ctx run data get storage catan:direct cost[4]
execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx
scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx
execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx
data modify storage catan:direct shortage.name set value "矿石"
execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage
execute unless score #direct_ready ca_ctx matches 1 run function catan:hud/notice with storage catan:direct failure
