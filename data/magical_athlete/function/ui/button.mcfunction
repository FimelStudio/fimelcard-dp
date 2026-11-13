# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code ma_ctx $(code)
scoreboard players operation #ui_code ma_ctx += #ui_base ma_ctx
execute store result storage magical_athlete:ui code int 1 run scoreboard players get #ui_code ma_ctx
$data modify storage magical_athlete:ui label set value "$(label)"
$data modify storage magical_athlete:ui color set value "$(color)"
function magical_athlete:ui/button_append with storage magical_athlete:ui
