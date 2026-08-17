# 只接受带Fast Card专用标记的纸牌
scoreboard players set #is_card fc_ctx 0
execute if items entity @s contents minecraft:paper[minecraft:custom_data~{fast_card:{card:1b}}] run scoreboard players set #is_card fc_ctx 1
execute if score #is_card fc_ctx matches 1 run function fast_card:pass/accept
