# 玩家本刻必须丢过纸，并且地面物品必须带Fast Card专用卡牌标记
scoreboard players set #is_return_card fc_ctx 0
execute if score @a[tag=fc.return_owner,limit=1] fc_drop_paper matches 1.. if items entity @s contents minecraft:paper[minecraft:custom_data~{fast_card:{card:1b}}] run scoreboard players set #is_return_card fc_ctx 1
execute if score #is_return_card fc_ctx matches 1 run function fast_card:pass/return_item
