# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #vis_table ll_ctx = @s ct_id
function love_letter:visual/deck_tick
execute as @e[type=minecraft:item_display,tag=ll.fx] if score @s ct_id = #vis_table ll_ctx run function love_letter:visual/fx_tick
