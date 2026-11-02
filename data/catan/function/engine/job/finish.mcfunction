data modify storage catan:engine state.phase set from storage catan:engine state.job.resume
data remove storage catan:engine state.job
scoreboard players set #max_metric ca_ctx 4
scoreboard players set #metric_count ca_ctx 0
scoreboard players set #best_owner ca_ctx 0
execute store result score #metric1 ca_ctx run data get storage catan:engine state.p1.road_length
execute store result score #metric2 ca_ctx run data get storage catan:engine state.p2.road_length
execute store result score #metric3 ca_ctx run data get storage catan:engine state.p3.road_length
execute store result score #metric4 ca_ctx run data get storage catan:engine state.p4.road_length
execute if score #n ca_ctx matches 1.. run function catan:engine/award/consider {player:1}
execute if score #n ca_ctx matches 2.. run function catan:engine/award/consider {player:2}
execute if score #n ca_ctx matches 3.. run function catan:engine/award/consider {player:3}
execute if score #n ca_ctx matches 4.. run function catan:engine/award/consider {player:4}
scoreboard players operation #old_owner ca_ctx = #longest ca_ctx
function catan:engine/award/resolve
execute store result storage catan:engine state.longest int 1 run scoreboard players get #new_owner ca_ctx
data modify storage catan:engine state.last set value {code:90,actor:0,target:-1,a:-1,b:-1,production:[]}
execute store result storage catan:engine state.last.actor int 1 run scoreboard players get #turn ca_ctx
scoreboard players set #changed ca_ctx 1
