scoreboard players set #item_allowed gd_ctx 0
scoreboard players operation #item_table gd_ctx = @s gd_table
scoreboard players operation #item_seat gd_ctx = @s gd_seat
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s gd_table run return 0
execute as @e[type=minecraft:marker,tag=gd.controller,scores={ct_state=1}] if score @s ct_id = #item_table gd_ctx run function guandan:input/tool_table
