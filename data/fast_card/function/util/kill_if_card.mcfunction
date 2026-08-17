# 本函数的执行者必须是物品实体
scoreboard players set #is_card fc_ctx 0
execute if items entity @s contents minecraft:paper[minecraft:custom_data~{fast_card:{card:1b}}] run scoreboard players set #is_card fc_ctx 1
execute if score #is_card fc_ctx matches 1 run kill @s
