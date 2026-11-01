execute store result score #drop_table ll_ctx run data get entity @s Item.components."minecraft:custom_data".love_letter.table
execute if score #drop_table ll_ctx = #table ll_ctx run kill @s
