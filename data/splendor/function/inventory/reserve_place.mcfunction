$execute if predicate {type:"minecraft:int_value_check",value:$(reserve_slot),test:0} run item replace entity @s hotbar.6 with $(stack)
$execute if predicate {type:"minecraft:int_value_check",value:$(reserve_slot),test:1} run item replace entity @s hotbar.7 with $(stack)
$execute if predicate {type:"minecraft:int_value_check",value:$(reserve_slot),test:2} run item replace entity @s hotbar.8 with $(stack)
