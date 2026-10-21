# 主动领出：对手报单时，尽量用非单张牌型阻止其直接出完。
execute if score #bot_enemy_min dd_ctx matches 1 if score #type dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 100
# 只针对单张、对子、三张及三带；长顺子等连牌不因最高点大而受罚。
execute unless score #type dd_ctx matches 1..5 run return 0
execute unless score #high dd_ctx matches 14..17 run return 0
# A、2和王可用于后续夺回牌权，主动领出增加保留代价。
execute if score #high dd_ctx matches 14 run scoreboard players add #bot_cost dd_ctx 18
execute if score #high dd_ctx matches 15 run scoreboard players add #bot_cost dd_ctx 32
execute if score #high dd_ctx matches 16..17 run scoreboard players add #bot_cost dd_ctx 48
# 检查候选出牌后的低散单，而非只看当前出牌数量。
scoreboard players operation #lead_left dd_ctx = #have3 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r3 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have4 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r4 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have5 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r5 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have6 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r6 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have7 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r7 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have8 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r8 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have9 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r9 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have10 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r10 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
scoreboard players operation #lead_left dd_ctx = #have11 dd_ctx
scoreboard players operation #lead_left dd_ctx -= #r11 dd_ctx
execute if score #lead_left dd_ctx matches 1 run scoreboard players add #bot_cost dd_ctx 14
