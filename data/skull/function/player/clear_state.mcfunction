dialog clear @s
clear @s *[minecraft:custom_data~{skull:{}}]
tag @s remove sk.player
tag @s remove sk.actor
tag @s remove sk.viewer
tag @s remove sk.receiver
tag @s remove sk.audience
scoreboard players reset @s sk_id
scoreboard players reset @s sk_seat
scoreboard players reset @s sk_alive
scoreboard players reset @s sk_wins
scoreboard players reset @s sk_count
scoreboard players reset @s sk_done
scoreboard players reset @s sk_pass
scoreboard players reset @s sk_left
scoreboard players reset @s sk_ui_table
scoreboard players reset @s sk_action
