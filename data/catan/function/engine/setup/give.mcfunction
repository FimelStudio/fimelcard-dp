$scoreboard players add #r$(resource) ca_ctx 1
$scoreboard players remove #bank$(resource) ca_ctx 1
$data modify storage catan:engine state.last.production append value {owner:0,hex:$(hex),resource:$(resource),amount:1}
execute store result storage catan:engine state.last.production[-1].owner int 1 run scoreboard players get #actor ca_ctx
