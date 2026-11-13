# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:1} run function magical_athlete:visual/move_frame with storage magical_athlete:visual event
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run function magical_athlete:visual/warp_frame with storage magical_athlete:visual event
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:9} run function magical_athlete:visual/dice_frame with storage magical_athlete:visual event
