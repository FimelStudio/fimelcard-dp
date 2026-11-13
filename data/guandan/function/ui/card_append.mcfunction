# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage guandan:ui stack_columns[-1].cards append value {slices:$(slices),command:"trigger gd_action set $(card_code)",name:"$(card_name)"}
