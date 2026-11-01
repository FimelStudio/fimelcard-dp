execute store result score #drop_table gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.table
execute if score #drop_table gd_ctx = #table gd_ctx run kill @s
