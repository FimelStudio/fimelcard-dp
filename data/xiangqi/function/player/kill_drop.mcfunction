execute store result score #drop_table xq_ctx run data get entity @s Item.components."minecraft:custom_data".xiangqi.table
execute if score #drop_table xq_ctx = #table xq_ctx run kill @s
