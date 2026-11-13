scoreboard players set @s gm_bot 0
execute if score @s ct_joined matches 1 run return run function gomoku:game/solo_sides
execute if score @s gm_first matches 0 run function gomoku:game/random_first
execute if score @s gm_first matches 1 run function gomoku:game/chosen_first
