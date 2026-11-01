scoreboard players add #epoch_serial ll_ctx 1
execute unless score #epoch_serial ll_ctx matches 10000..999999 run scoreboard players set #epoch_serial ll_ctx 10000
scoreboard players operation @s ll_epoch = #epoch_serial ll_ctx
