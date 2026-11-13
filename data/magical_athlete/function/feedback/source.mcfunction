$data modify storage magical_athlete:feedback source set value {source_actor:$(source_actor),target_owner:$(actor),target_name:"$(name)",power:$(source)}
$data modify storage magical_athlete:feedback source.ability_name set from storage magical_athlete:characters chars[$(source)].name
scoreboard players set #source_count ma_ctx 0
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:0,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:1,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:2,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:3,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:4,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} run function magical_athlete:feedback/source_candidate {index:5,power:$(source)}
$execute if predicate {condition:"minecraft:value_check",value:$(source_actor),range:-1} unless score #source_count ma_ctx matches 1 run return run function magical_athlete:feedback/source_unknown with storage magical_athlete:feedback source
function magical_athlete:feedback/source_actor with storage magical_athlete:feedback source
