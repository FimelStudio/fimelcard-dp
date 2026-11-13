scoreboard players set #max_metric ca_ctx 2
scoreboard players set #metric_count ca_ctx 0
scoreboard players set #best_owner ca_ctx 0
execute store result score #metric1 ca_ctx run data get storage catan:engine state.p1.knights
execute store result score #metric2 ca_ctx run data get storage catan:engine state.p2.knights
execute store result score #metric3 ca_ctx run data get storage catan:engine state.p3.knights
execute store result score #metric4 ca_ctx run data get storage catan:engine state.p4.knights
execute if score #n ca_ctx matches 1.. run function catan:engine/award/consider {player:1}
execute if score #n ca_ctx matches 2.. run function catan:engine/award/consider {player:2}
execute if score #n ca_ctx matches 3.. run function catan:engine/award/consider {player:3}
execute if score #n ca_ctx matches 4.. run function catan:engine/award/consider {player:4}
scoreboard players operation #old_owner ca_ctx = #army ca_ctx
function catan:engine/award/resolve
scoreboard players operation #army ca_ctx = #new_owner ca_ctx
execute store result storage catan:engine state.army int 1 run scoreboard players get #army ca_ctx
execute if score #n ca_ctx matches 1.. run function catan:engine/stats_p1
execute if score #n ca_ctx matches 2.. run function catan:engine/stats_p2
execute if score #n ca_ctx matches 3.. run function catan:engine/stats_p3
execute if score #n ca_ctx matches 4.. run function catan:engine/stats_p4
