# 当前执行者是地面物品；只有带本游戏标记且table等于当前控制器上下文才删除
scoreboard players set #item_table lh_ctx -1
execute if items entity @s contents *[minecraft:custom_data~{liars_holdem:{}}] store result score #item_table lh_ctx run data get entity @s Item.components."minecraft:custom_data".liars_holdem.table
execute if score #item_table lh_ctx = #ctx_id lh_ctx run kill @s
