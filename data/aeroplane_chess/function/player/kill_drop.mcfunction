execute store result score #drop_table ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.table
execute if score #drop_table ac_ctx = #table ac_ctx run kill @s
