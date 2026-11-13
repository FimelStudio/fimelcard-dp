$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:4} run return run function catan:direct/vp_note
$execute if predicate {type:"minecraft:int_value_check",value:$(fresh),test:1} run return run function catan:direct/fresh_note
$scoreboard players set #code ca_ctx $(id)
scoreboard players add #code ca_ctx 600
function catan:direct/dev_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
function catan:direct/submit
