# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
clear @s minecraft:book[minecraft:custom_data~{doudizhu:{}}]
execute unless score #tool_phase dd_ctx matches 2..3 run return run function doudizhu:input/clear
execute unless score #tool_turn dd_ctx matches -1 unless score @s dd_seat = #tool_turn dd_ctx run return run function doudizhu:input/clear
execute unless items entity @s inventory.* minecraft:purple_dye[minecraft:custom_data~{doudizhu:{tool:"hand"}}] unless items entity @s hotbar.* minecraft:purple_dye[minecraft:custom_data~{doudizhu:{tool:"hand"}}] unless items entity @s weapon.offhand minecraft:purple_dye[minecraft:custom_data~{doudizhu:{tool:"hand"}}] run function doudizhu:input/give
