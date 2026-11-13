# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code ac_ctx $(code)
scoreboard players operation #ui_code ac_ctx += #ui_base ac_ctx
execute store result storage aeroplane_chess:ui code int 1 run scoreboard players get #ui_code ac_ctx
$data modify storage aeroplane_chess:ui label set value "$(label)"
function aeroplane_chess:ui/append_button with storage aeroplane_chess:ui
