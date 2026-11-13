# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @e[tag=gd.uicards] run return 0
scoreboard players set #ui_max gd_ctx -1
execute as @e[tag=gd.uicards] run scoreboard players operation #ui_max gd_ctx > @s gd_ui_key
execute as @e[tag=gd.uicards] if score @s gd_ui_key = #ui_max gd_ctx run function guandan:ui/card
function guandan:ui/next_card
