$scoreboard players operation #amount ca_ctx = #vl$(vertex) ca_ctx
$scoreboard players operation #amount ca_ctx < #grant$(owner)_$(resource) ca_ctx
$scoreboard players operation #res$(owner)_$(resource) ca_ctx += #amount ca_ctx
$scoreboard players operation #grant$(owner)_$(resource) ca_ctx -= #amount ca_ctx
$scoreboard players operation #bank$(resource) ca_ctx -= #amount ca_ctx
$data modify storage catan:engine state.last.production append value {owner:$(owner),hex:$(hex),resource:$(resource),amount:0}
execute store result storage catan:engine state.last.production[-1].amount int 1 run scoreboard players get #amount ca_ctx
