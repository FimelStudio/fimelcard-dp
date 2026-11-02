$execute unless score #actor ca_ctx matches 1 run scoreboard players operation #r$(a) ca_ctx += #res1_$(a) ca_ctx
$execute unless score #actor ca_ctx matches 1 run data modify storage catan:engine state.p1.resources[$(a)] set value 0
$execute unless score #actor ca_ctx matches 2 run scoreboard players operation #r$(a) ca_ctx += #res2_$(a) ca_ctx
$execute unless score #actor ca_ctx matches 2 run data modify storage catan:engine state.p2.resources[$(a)] set value 0
$execute unless score #actor ca_ctx matches 3 run scoreboard players operation #r$(a) ca_ctx += #res3_$(a) ca_ctx
$execute unless score #actor ca_ctx matches 3 run data modify storage catan:engine state.p3.resources[$(a)] set value 0
$execute unless score #actor ca_ctx matches 4 run scoreboard players operation #r$(a) ca_ctx += #res4_$(a) ca_ctx
$execute unless score #actor ca_ctx matches 4 run data modify storage catan:engine state.p4.resources[$(a)] set value 0
