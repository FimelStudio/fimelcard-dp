scoreboard players operation #used ca_ctx = #node_mask ca_ctx
scoreboard players operation #used ca_ctx /= #bit ca_ctx
scoreboard players operation #used ca_ctx %= #two ca_ctx
execute if score #used ca_ctx matches 1 run return 0
scoreboard players operation #newmask ca_ctx = #node_mask ca_ctx
scoreboard players operation #newmask ca_ctx += #bit ca_ctx
scoreboard players operation #newlength ca_ctx = #node_length ca_ctx
scoreboard players add #newlength ca_ctx 1
$data modify storage catan:engine state.job.stack append value {vertex:$(to),mask:0,length:0}
execute store result storage catan:engine state.job.stack[-1].mask int 1 run scoreboard players get #newmask ca_ctx
execute store result storage catan:engine state.job.stack[-1].length int 1 run scoreboard players get #newlength ca_ctx
