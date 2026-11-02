# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={gomoku:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={gomoku:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
