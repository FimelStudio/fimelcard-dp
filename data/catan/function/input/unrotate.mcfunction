# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #swap ca_ctx = #x ca_ctx
scoreboard players operation #x ca_ctx = #z ca_ctx
scoreboard players operation #z ca_ctx = #swap ca_ctx
scoreboard players operation #z ca_ctx *= #minus ca_ctx
