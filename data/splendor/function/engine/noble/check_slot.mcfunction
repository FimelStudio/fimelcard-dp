$execute store result score #noble sp_ctx run data get storage splendor:engine state.nobles[$(slot)]
execute unless score #noble sp_ctx matches 0..9 run return 0
execute store result storage splendor:engine noble.id int 1 run scoreboard players get #noble sp_ctx
$data modify storage splendor:engine noble.slot set value $(slot)
function splendor:engine/noble/check_cost with storage splendor:engine noble
