# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation @s gd_ui_key = @s gd_strength
scoreboard players set #ui_key_factor gd_ctx 108
scoreboard players operation @s gd_ui_key *= #ui_key_factor gd_ctx
scoreboard players operation @s gd_ui_key += @s gd_id
