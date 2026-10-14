# 每轮先保存实际剩余牌，再收起；不补回已使用的牌。
tag @s remove cp.held_1
execute store result score #held cp_ctx run clear @s minecraft:paper[minecraft:custom_data~{critical_point:{card:1b}}] 0
execute if score #held cp_ctx matches 1.. run tag @s add cp.held_1
tag @s remove cp.held_2
execute store result score #held cp_ctx run clear @s minecraft:paper[minecraft:custom_data~{critical_point:{card:2b}}] 0
execute if score #held cp_ctx matches 1.. run tag @s add cp.held_2
tag @s remove cp.held_3
execute store result score #held cp_ctx run clear @s minecraft:paper[minecraft:custom_data~{critical_point:{card:3b}}] 0
execute if score #held cp_ctx matches 1.. run tag @s add cp.held_3
tag @s remove cp.held_4
execute store result score #held cp_ctx run clear @s minecraft:paper[minecraft:custom_data~{critical_point:{card:4b}}] 0
execute if score #held cp_ctx matches 1.. run tag @s add cp.held_4
tag @s remove cp.held_5
execute store result score #held cp_ctx run clear @s minecraft:paper[minecraft:custom_data~{critical_point:{card:5b}}] 0
execute if score #held cp_ctx matches 1.. run tag @s add cp.held_5
clear @s minecraft:paper[minecraft:custom_data~{critical_point:{}}]
