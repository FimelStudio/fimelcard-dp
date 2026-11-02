# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code xq_ctx $(code)
scoreboard players operation #ui_code xq_ctx += #ui_base xq_ctx
execute store result storage xiangqi:ui code int 1 run scoreboard players get #ui_code xq_ctx
$data modify storage xiangqi:ui label set value "$(label)"
$data modify storage xiangqi:ui color set value "$(color)"
function xiangqi:ui/button_append with storage xiangqi:ui
