# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:inventory dropped set value {asset:0b,kind:-1,table:-1,owner:-1,color:-1,epoch:-1,reserve_slot:-1}
data modify storage splendor:inventory dropped merge from entity @s Item.components."minecraft:custom_data".splendor
execute if data storage splendor:inventory dropped{asset:1b} on origin if entity @s[type=minecraft:player,tag=sp.player] run function splendor:inventory/drop with storage splendor:inventory dropped
kill @s
