scoreboard players set @s xq_bot 0
execute if score @s ct_joined matches 1 run return run function xiangqi:game/solo_sides
execute if score @s xq_first matches 0 run function xiangqi:game/random_first
execute if score @s xq_first matches 1 run function xiangqi:game/chosen_first
