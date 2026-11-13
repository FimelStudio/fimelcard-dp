# 单人也保留入座选边／随机黑白的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side gm_ctx 1
execute if score @s gm_first matches 0 store result score #human_side gm_ctx run random value 0..1
execute if score #human_side gm_ctx matches 0 run scoreboard players set #human_side gm_ctx -1
execute if score @s gm_first matches 1 run scoreboard players operation #human_side gm_ctx = @a[tag=gm.audience,limit=1] gm_weight
scoreboard players operation @a[tag=gm.audience,limit=1] gm_side = #human_side gm_ctx
scoreboard players operation @s gm_bot = #human_side gm_ctx
scoreboard players operation @s gm_bot *= #minus gm_ctx
