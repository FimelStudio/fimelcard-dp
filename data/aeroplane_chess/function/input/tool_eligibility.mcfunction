# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #item_allowed ac_ctx 0
scoreboard players operation #item_table ac_ctx = @s ac_table
scoreboard players operation #item_seat ac_ctx = @s ac_color
execute unless entity @s[tag=ac.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s ac_table run return 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_game=15,ct_state=1}] if score @s ct_id = #item_table ac_ctx run function aeroplane_chess:input/tool_table
