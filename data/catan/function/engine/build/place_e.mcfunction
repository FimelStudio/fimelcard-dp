$execute store result storage catan:engine state.road_owner[$(target)] int 1 run scoreboard players get #actor ca_ctx
scoreboard players remove #roads_left ca_ctx 1
$execute store result storage catan:engine state.p$(actor).roads_left int 1 run scoreboard players get #roads_left ca_ctx
