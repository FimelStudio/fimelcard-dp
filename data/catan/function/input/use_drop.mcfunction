# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless score @a[tag=ca.dropper,limit=1] ca_table matches $(table) run return 0
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:0} as @a[tag=ca.dropper,limit=1] run function catan:input/roll
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:1} as @a[tag=ca.dropper,limit=1] run function catan:input/aim
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:29} as @a[tag=ca.dropper,limit=1] run function catan:direct/end_turn
execute as @a[tag=ca.dropper,limit=1] run function catan:input/give
