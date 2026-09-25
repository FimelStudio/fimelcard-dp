scoreboard players set #item_table wq_ctx -1
execute store result score #item_table wq_ctx run data get entity @s Item.components."minecraft:custom_data".wenfei.table
execute unless score #item_table wq_ctx = #scan_table wq_ctx run return 0
tag @e[tag=wq.drop] remove wq.drop
tag @s add wq.drop
execute on origin if entity @s[tag=wq.player] if score @s wq_id = #item_table wq_ctx run function wenfei:input/from_player
tag @s remove wq.drop
