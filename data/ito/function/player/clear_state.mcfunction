function ito:hud/deactivate
clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
dialog clear @s
tag @s remove it.player
tag @s remove it.audience
scoreboard players reset @s it_table
scoreboard players reset @s it_seat
scoreboard players reset @s it_action
scoreboard players reset @s it_window
scoreboard players reset @s it_form
scoreboard players reset @s it_total
scoreboard players reset @s it_offer
scoreboard players reset @s it_done
scoreboard players reset @s it_sum
scoreboard players reset @s it_rank
tag @s remove it.partner
tag @s remove it.winner
