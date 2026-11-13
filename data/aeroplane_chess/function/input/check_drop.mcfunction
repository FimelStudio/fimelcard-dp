# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #owner ac_ctx 0
execute on origin if entity @s[tag=ac.dropper,tag=ac.player] run scoreboard players set #owner ac_ctx 1
execute unless score #owner ac_ctx matches 1 run return 0
execute store result score #tool ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.action
execute store result score #tool_table ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.table
kill @s
execute unless score @a[tag=ac.dropper,limit=1] ac_table = #tool_table ac_ctx run return 0
execute as @a[tag=ac.dropper,limit=1] run function aeroplane_chess:input/give
execute as @a[tag=ac.dropper,limit=1] at @s run function aeroplane_chess:input/tool_use
