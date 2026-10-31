execute store result score #drop_table ch_ctx run data get entity @s Item.components."minecraft:custom_data".chess.table
execute if score #drop_table ch_ctx = #table ch_ctx run kill @s
