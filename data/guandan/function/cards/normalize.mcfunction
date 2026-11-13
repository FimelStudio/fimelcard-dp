# 执行者为实体牌，#level gd_ctx 为本副级牌；不改所有权、选中、使用状态。
scoreboard players operation @s gd_point = @s gd_type
scoreboard players operation @s gd_point %= #13 gd_ctx
scoreboard players add @s gd_point 2
scoreboard players operation @s gd_suit = @s gd_type
scoreboard players operation @s gd_suit /= #13 gd_ctx
execute if score @s gd_type matches 52.. run scoreboard players set @s gd_suit -1
execute if score @s gd_type matches 52 run scoreboard players set @s gd_point 15
execute if score @s gd_type matches 53 run scoreboard players set @s gd_point 16
scoreboard players set @s gd_wild 0
execute if score @s gd_suit matches 2 if score @s gd_point = #level gd_ctx run scoreboard players set @s gd_wild 1
scoreboard players operation @s gd_strength = @s gd_point
execute if score @s gd_point = #level gd_ctx run scoreboard players set @s gd_strength 15
execute if score @s gd_type matches 52 run scoreboard players set @s gd_strength 16
execute if score @s gd_type matches 53 run scoreboard players set @s gd_strength 17
