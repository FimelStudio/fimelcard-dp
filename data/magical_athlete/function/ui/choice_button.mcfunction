execute if entity @s[tag=ma.inventory_choices] run return run function magical_athlete:direct/choice_copy
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$function magical_athlete:ui/button {code:$(code),label:"$(label)",color:"green"}
