# 用2作为临时值，避免同一函数中0改1后又被下一条命令改回0。
execute if score @s dc_encoder matches 0 run scoreboard players set @s dc_encoder 2
execute if score @s dc_encoder matches 1 run scoreboard players set @s dc_encoder 0
execute if score @s dc_encoder matches 2 run scoreboard players set @s dc_encoder 1
