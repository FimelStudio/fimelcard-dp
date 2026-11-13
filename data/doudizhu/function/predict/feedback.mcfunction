scoreboard players operation #my_margin dd_ctx = #red_margin dd_ctx
scoreboard players set #negate dd_ctx -1
execute if score @s dd_team matches 2 run scoreboard players operation #my_margin dd_ctx *= #negate dd_ctx
scoreboard players set #correct_prediction dd_ctx 0
execute if score #my_margin dd_ctx matches 0..6 if score @s dd_prediction matches 1 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches 7..12 if score @s dd_prediction matches 2 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches 13..17 if score @s dd_prediction matches 3 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches 18.. if score @s dd_prediction matches 4 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches -6..0 if score @s dd_prediction matches 5 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches -12..-7 if score @s dd_prediction matches 6 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches -17..-13 if score @s dd_prediction matches 7 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #my_margin dd_ctx matches ..-18 if score @s dd_prediction matches 8 run scoreboard players set #correct_prediction dd_ctx 1
execute if score #correct_prediction dd_ctx matches 1 run tellraw @s {text:"你的比分预测正确。",color:"green"}
execute unless score #correct_prediction dd_ctx matches 1 run tellraw @s {text:"你的比分预测不正确。",color:"yellow"}
