$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:1} run function magical_athlete:sound/step
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run function magical_athlete:sound/warp
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:3} run function magical_athlete:sound/trip
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} run function magical_athlete:sound/land
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:5} run function magical_athlete:sound/trip
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run function magical_athlete:sound/finish
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:7} run function magical_athlete:sound/coin
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:8} run function magical_athlete:sound/skill
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:9} run function magical_athlete:sound/roll
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:{min:2,max:8}} run particle minecraft:happy_villager ~ ~1.3 ~ 0.6 0.1 0.6 0.02 10 normal @a[tag=ma.audience]
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run particle minecraft:firework ~ ~1.5 ~ 0.7 0.3 0.7 0.08 20 normal @a[tag=ma.audience]
