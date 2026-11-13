# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code un_ctx $(code)
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui code int 1 run scoreboard players get #ui_code un_ctx
$data modify storage uno:ui label set value "$(label)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/control_append with storage uno:ui
