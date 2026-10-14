execute if entity @s[tag=cp.held_1] run item replace entity @s hotbar.0 with minecraft:paper[minecraft:item_model='card:poker/c_a',minecraft:item_name='临界点 · 1点',minecraft:custom_data={critical_point:{card:1b}},minecraft:max_stack_size=1]
execute if entity @s[tag=cp.held_2] run item replace entity @s hotbar.1 with minecraft:paper[minecraft:item_model='card:poker/c_2',minecraft:item_name='临界点 · 2点',minecraft:custom_data={critical_point:{card:2b}},minecraft:max_stack_size=1]
execute if entity @s[tag=cp.held_3] run item replace entity @s hotbar.2 with minecraft:paper[minecraft:item_model='card:poker/c_3',minecraft:item_name='临界点 · 3点',minecraft:custom_data={critical_point:{card:3b}},minecraft:max_stack_size=1]
execute if entity @s[tag=cp.held_4] run item replace entity @s hotbar.3 with minecraft:paper[minecraft:item_model='card:poker/c_4',minecraft:item_name='临界点 · 4点',minecraft:custom_data={critical_point:{card:4b}},minecraft:max_stack_size=1]
execute if entity @s[tag=cp.held_5] run item replace entity @s hotbar.4 with minecraft:paper[minecraft:item_model='card:poker/c_5',minecraft:item_name='临界点 · 5点',minecraft:custom_data={critical_point:{card:5b}},minecraft:max_stack_size=1]
execute if entity @s[tag=cp.held_6] run scoreboard players set @s cp_play 0
execute if entity @s[tag=cp.held_7] run scoreboard players set @s cp_locked 0
execute if entity @s[tag=cp.held_8] run scoreboard players set @s cp_ready 0
execute if entity @s[tag=cp.held_9] run scoreboard players set @s cp_vote 0
execute if entity @s[tag=cp.held_10] run scoreboard players set @s cp_drop 0
execute if entity @s[tag=cp.held_11] run scoreboard players set @s cp_drop_red 0
execute if entity @s[tag=cp.held_12] run scoreboard players set @s cp_drop_lime 0
execute if entity @s[tag=cp.held_13] run scoreboard players set @s cp_drop_reopen 0
execute if entity @s[tag=cp.held_14] run scoreboard players set @s cp_action 0
