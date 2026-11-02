# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code ll_ctx $(code)
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui code int 1 run scoreboard players get #ui_code ll_ctx
$data modify storage love_letter:ui label set value {text:"$(label)",color:"$(color)"}
function love_letter:ui/button_append with storage love_letter:ui
