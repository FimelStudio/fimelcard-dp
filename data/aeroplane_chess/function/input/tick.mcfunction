# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:interaction,tag=ac.dice_click] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s interaction at @s run function aeroplane_chess:input/dice
execute as @e[type=minecraft:interaction,tag=ac.plane_click] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s interaction at @s run function aeroplane_chess:input/plane
execute as @a[tag=ac.player,scores={ac_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function aeroplane_chess:input/drop
execute as @a[tag=ac.player,scores={ac_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function aeroplane_chess:input/submit
execute as @a[scores={ac_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function aeroplane_chess:settings/save
execute as @a[tag=ac.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function aeroplane_chess:input/sync_turn_tool
