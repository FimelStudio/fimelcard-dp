# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s gd_state matches 3 if score @s gd_turn = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1
execute if score @s gd_state matches 2 if score @s gd_phase matches 1 as @e[type=minecraft:marker,tag=gd.part,scores={gd_tribute=1}] if score @s ct_id = #item_table gd_ctx if score @s gd_seat = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1
execute if score @s gd_state matches 2 if score @s gd_phase matches 2 as @e[type=minecraft:marker,tag=gd.part,scores={gd_return=1}] if score @s ct_id = #item_table gd_ctx if score @s gd_seat = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1
