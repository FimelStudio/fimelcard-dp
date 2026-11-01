scoreboard players add #epoch_serial gd_ctx 1
execute unless score #epoch_serial gd_ctx matches 10000..999999 run scoreboard players set #epoch_serial gd_ctx 10000
scoreboard players operation @s gd_epoch = #epoch_serial gd_ctx
