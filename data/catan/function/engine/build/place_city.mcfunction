$data modify storage catan:engine state.vertex_level[$(target)] set value 2
scoreboard players add #settlements_left ca_ctx 1
scoreboard players remove #cities_left ca_ctx 1
$execute store result storage catan:engine state.p$(actor).settlements_left int 1 run scoreboard players get #settlements_left ca_ctx
$execute store result storage catan:engine state.p$(actor).cities_left int 1 run scoreboard players get #cities_left ca_ctx
