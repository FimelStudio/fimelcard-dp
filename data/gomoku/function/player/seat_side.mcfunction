scoreboard players set @s gm_weight 0
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 if score @s ct_seat matches 3 run scoreboard players set @s gm_weight 1
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 if score @s ct_seat matches 1 run scoreboard players set @s gm_weight -1
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 if score @s ct_seat matches 4 run scoreboard players set @s gm_weight 1
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 if score @s ct_seat matches 2 run scoreboard players set @s gm_weight -1
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 if score @s ct_seat matches 5..6 run scoreboard players set @s gm_weight 1
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 if score @s ct_seat matches 1..2 run scoreboard players set @s gm_weight -1
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 if score @s ct_seat matches 7..8 run scoreboard players set @s gm_weight 1
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 if score @s ct_seat matches 3..4 run scoreboard players set @s gm_weight -1
