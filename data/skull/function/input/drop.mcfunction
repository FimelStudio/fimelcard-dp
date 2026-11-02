# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #drop_table sk_ctx -1
execute store result score #drop_table sk_ctx run data get entity @s Item.components."minecraft:custom_data".skull.table
execute unless score #drop_table sk_ctx = #scan sk_ctx run return 0
tag @e[tag=sk.drop] remove sk.drop
tag @s add sk.drop
execute on origin if entity @s[tag=sk.player] if score @s sk_id = #drop_table sk_ctx at @s run function skull:input/from_player
tag @s remove sk.drop
