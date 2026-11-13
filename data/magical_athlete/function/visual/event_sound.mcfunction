$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:1} run function magical_athlete:sound/step
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:2} run function magical_athlete:sound/warp
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:3} run function magical_athlete:sound/trip
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:4} run function magical_athlete:sound/land
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:5} run function magical_athlete:sound/trip
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:6} run function magical_athlete:sound/finish
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:7} run function magical_athlete:sound/coin
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:8} run function magical_athlete:sound/skill
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:9} run function magical_athlete:sound/roll
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:{min:2,max:8}} run particle minecraft:happy_villager ~ ~1.3 ~ 0.6 0.1 0.6 0.02 10 normal @a[tag=ma.audience]
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:6} run particle minecraft:firework ~ ~1.5 ~ 0.7 0.3 0.7 0.08 20 normal @a[tag=ma.audience]
