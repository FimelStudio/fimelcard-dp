$execute if predicate {condition:"minecraft:value_check",value:$(id),range:4} run return run function catan:direct/vp_note
$execute if predicate {condition:"minecraft:value_check",value:$(fresh),range:1} run return run function catan:direct/fresh_note
$scoreboard players set #code ca_ctx $(id)
scoreboard players add #code ca_ctx 600
function catan:direct/confirm
