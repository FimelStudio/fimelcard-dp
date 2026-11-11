execute store result score #prediction_table dd_ctx run data get entity @s Item.components."minecraft:custom_data".doudizhu.table
execute store result score #prediction_token dd_ctx run data get entity @s Item.components."minecraft:custom_data".doudizhu.token
execute store result score #prediction_choice dd_ctx run data get entity @s Item.components."minecraft:custom_data".doudizhu.prediction
execute on origin if entity @s[tag=dd.player,tag=ct.player] unless score @s ct_paused matches 1 run function doudizhu:predict/from_dye
kill @s
