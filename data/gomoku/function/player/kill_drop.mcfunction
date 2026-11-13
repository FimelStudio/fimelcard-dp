execute store result score #drop_table gm_ctx run data get entity @s Item.components."minecraft:custom_data".gomoku.table
execute if score #drop_table gm_ctx = #table gm_ctx run kill @s
