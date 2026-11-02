# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui person set from entity @s data.catan.p$(side)
$data modify storage catan:ui person.side set value $(side)
$data modify storage catan:ui person.color_label set value "$(label)"
$data modify storage catan:ui person.color set value "$(color)"
function catan:ui/public_append with storage catan:ui person
