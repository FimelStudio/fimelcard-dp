# 单人也保留入座选边／随机红黑的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side xq_ctx 1
execute if score @s xq_first matches 0 store result score #human_side xq_ctx run random value 0..1
execute if score #human_side xq_ctx matches 0 run scoreboard players set #human_side xq_ctx -1
execute if score @s xq_first matches 1 run scoreboard players operation #human_side xq_ctx = @a[tag=xq.audience,limit=1] xq_weight
scoreboard players operation @a[tag=xq.audience,limit=1] xq_side = #human_side xq_ctx
scoreboard players operation @s xq_bot = #human_side xq_ctx
scoreboard players operation @s xq_bot *= #minus xq_ctx
