# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code ch_ctx $(code)
scoreboard players operation #ui_code ch_ctx += #ui_base ch_ctx
execute store result storage chess:ui code int 1 run scoreboard players get #ui_code ch_ctx
$data modify storage chess:ui label set value "$(label)"
$data modify storage chess:ui color set value "$(color)"
function chess:ui/button_append with storage chess:ui
