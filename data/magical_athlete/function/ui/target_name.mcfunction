# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui target_char set from storage magical_athlete:characters chars[$(char)]
function magical_athlete:ui/character_label_show with storage magical_athlete:ui target_char
