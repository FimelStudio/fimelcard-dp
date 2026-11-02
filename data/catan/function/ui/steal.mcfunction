# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:ui/prepare
data modify storage catan:action input.code set value 13
$data modify storage catan:action input.target set value $(target)
function catan:ui/submit
