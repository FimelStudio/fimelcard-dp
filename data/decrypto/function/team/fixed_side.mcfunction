# 由真实座位推导队伍；只写临时分数，供开局校验与分队共同使用。
scoreboard players set #fixed_side dc_ctx 2
execute unless score #team_capacity dc_ctx matches 8 if score @s ct_seat matches 1 run scoreboard players set #fixed_side dc_ctx 1
execute unless score #team_capacity dc_ctx matches 8 if score @s ct_seat matches 3 run scoreboard players set #fixed_side dc_ctx 1
execute if score #team_capacity dc_ctx matches 8 if score @s ct_seat matches 1..2 run scoreboard players set #fixed_side dc_ctx 1
execute if score #team_capacity dc_ctx matches 8 if score @s ct_seat matches 5..6 run scoreboard players set #fixed_side dc_ctx 1
