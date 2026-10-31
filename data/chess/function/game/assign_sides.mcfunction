scoreboard players set @s ch_bot 0
execute if score @s ct_joined matches 1 run return run function chess:game/solo_sides
execute if score @s ch_first matches 0 run function chess:game/random_first
execute if score @s ch_first matches 1 run function chess:game/chosen_first
