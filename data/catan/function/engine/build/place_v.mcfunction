$execute store result storage catan:engine state.vertex_owner[$(target)] int 1 run scoreboard players get #actor ca_ctx
$data modify storage catan:engine state.vertex_level[$(target)] set value 1
scoreboard players remove #settlements_left ca_ctx 1
$execute store result storage catan:engine state.p$(actor).settlements_left int 1 run scoreboard players get #settlements_left ca_ctx
