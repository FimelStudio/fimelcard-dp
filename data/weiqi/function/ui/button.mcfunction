# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code go_ctx $(code)
scoreboard players operation #ui_code go_ctx += #ui_base go_ctx
execute store result storage weiqi:ui code int 1 run scoreboard players get #ui_code go_ctx
$data modify storage weiqi:ui label set value "$(label)"
$data modify storage weiqi:ui color set value "$(color)"
function weiqi:ui/button_append with storage weiqi:ui
