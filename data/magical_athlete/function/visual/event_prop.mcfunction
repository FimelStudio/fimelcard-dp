data modify storage magical_athlete:visual prop set value "flag"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run data modify storage magical_athlete:visual prop set value "portal"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:3} run data modify storage magical_athlete:visual prop set value "trip"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} run data modify storage magical_athlete:visual prop set value "flag"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:5} run data modify storage magical_athlete:visual prop set value "trip"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run data modify storage magical_athlete:visual prop set value "medal_gold"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:7} run data modify storage magical_athlete:visual prop set value "coin"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:8} run data modify storage magical_athlete:visual prop set value "rocket"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:9} run data modify storage magical_athlete:visual prop set value "flag"
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run function magical_athlete:visual/medal with storage magical_athlete:visual event
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:{min:2,max:8}} run execute positioned ~ ~1.2 ~ summon minecraft:item_display run function magical_athlete:visual/prop_init with storage magical_athlete:visual
