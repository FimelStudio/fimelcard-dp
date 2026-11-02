# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #owner sp_ctx 0
execute on origin if entity @s[tag=sp.dropper] run scoreboard players set #owner sp_ctx 1
execute unless score #owner sp_ctx matches 1 run return 0
data modify storage splendor:input drop set from entity @s Item.components."minecraft:custom_data".splendor
function splendor:input/use_drop with storage splendor:input drop
kill @s
