$execute unless score @a[tag=ca.dropper,limit=1] ca_table matches $(table) run return 0
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:0} as @a[tag=ca.dropper,limit=1] run function catan:ui/open
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:1} as @a[tag=ca.dropper,limit=1] run function catan:input/aim
execute as @a[tag=ca.dropper,limit=1] run function catan:input/give
