# 单人也保留入座选边／随机黑白的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side ch_ctx 1
execute if score @s ch_first matches 0 store result score #human_side ch_ctx run random value 0..1
execute if score #human_side ch_ctx matches 0 run scoreboard players set #human_side ch_ctx -1
execute if score @s ch_first matches 1 run scoreboard players operation #human_side ch_ctx = @a[tag=ch.audience,limit=1] ch_weight
scoreboard players operation @a[tag=ch.audience,limit=1] ch_side = #human_side ch_ctx
scoreboard players operation @s ch_bot = #human_side ch_ctx
scoreboard players operation @s ch_bot *= #minus ch_ctx
