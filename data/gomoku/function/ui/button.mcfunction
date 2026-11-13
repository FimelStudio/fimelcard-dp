# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code gm_ctx $(code)
scoreboard players operation #ui_code gm_ctx += #ui_base gm_ctx
execute store result storage gomoku:ui code int 1 run scoreboard players get #ui_code gm_ctx
$data modify storage gomoku:ui label set value "$(label)"
$data modify storage gomoku:ui color set value "$(color)"
function gomoku:ui/button_append with storage gomoku:ui
