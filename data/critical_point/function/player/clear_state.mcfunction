clear @s minecraft:paper[minecraft:custom_data~{critical_point:{}}]
clear @s minecraft:red_dye[minecraft:custom_data~{critical_point:{}}]
clear @s minecraft:lime_dye[minecraft:custom_data~{critical_point:{}}]
clear @s minecraft:purple_dye[minecraft:custom_data~{critical_point:{}}]
clear @s minecraft:black_dye[minecraft:custom_data~{critical_point:{}}]
clear @s minecraft:white_dye[minecraft:custom_data~{critical_point:{}}]
tag @s remove cp.signal_used
tag @s remove cp.player
tag @s remove cp.wolf
scoreboard players reset @s cp_id
scoreboard players reset @s cp_seat
scoreboard players reset @s cp_role
scoreboard players reset @s cp_play
scoreboard players reset @s cp_locked
scoreboard players reset @s cp_ready
scoreboard players reset @s cp_vote
scoreboard players reset @s cp_action
scoreboard players reset @s cp_drop
scoreboard players reset @s cp_drop_red
scoreboard players reset @s cp_drop_lime
scoreboard players reset @s cp_drop_reopen
