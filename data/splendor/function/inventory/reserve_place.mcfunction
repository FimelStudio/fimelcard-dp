$execute if predicate {condition:"minecraft:value_check",value:$(reserve_slot),range:0} run item replace entity @s hotbar.6 with $(stack)
$execute if predicate {condition:"minecraft:value_check",value:$(reserve_slot),range:1} run item replace entity @s hotbar.7 with $(stack)
$execute if predicate {condition:"minecraft:value_check",value:$(reserve_slot),range:2} run item replace entity @s hotbar.8 with $(stack)
