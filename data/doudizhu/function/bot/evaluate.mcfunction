# 越低越优：多出牌、低主牌；拆组合及过早动用炸弹有额外代价。
scoreboard players operation #bot_cost dd_ctx = #high dd_ctx
scoreboard players operation #bot_gain dd_ctx = #n dd_ctx
scoreboard players set #bot_weight dd_ctx 12
scoreboard players operation #bot_gain dd_ctx *= #bot_weight dd_ctx
scoreboard players operation #bot_cost dd_ctx -= #bot_gain dd_ctx
execute if score #r3 dd_ctx matches 1.. if score #r3 dd_ctx < #have3 dd_ctx if score #have3 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r3 dd_ctx matches 1.. if score #r3 dd_ctx < #have3 dd_ctx if score #have3 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r3 dd_ctx matches 1.. if score #r3 dd_ctx < #have3 dd_ctx if score #have3 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r4 dd_ctx matches 1.. if score #r4 dd_ctx < #have4 dd_ctx if score #have4 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r4 dd_ctx matches 1.. if score #r4 dd_ctx < #have4 dd_ctx if score #have4 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r4 dd_ctx matches 1.. if score #r4 dd_ctx < #have4 dd_ctx if score #have4 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r5 dd_ctx matches 1.. if score #r5 dd_ctx < #have5 dd_ctx if score #have5 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r5 dd_ctx matches 1.. if score #r5 dd_ctx < #have5 dd_ctx if score #have5 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r5 dd_ctx matches 1.. if score #r5 dd_ctx < #have5 dd_ctx if score #have5 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r6 dd_ctx matches 1.. if score #r6 dd_ctx < #have6 dd_ctx if score #have6 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r6 dd_ctx matches 1.. if score #r6 dd_ctx < #have6 dd_ctx if score #have6 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r6 dd_ctx matches 1.. if score #r6 dd_ctx < #have6 dd_ctx if score #have6 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r7 dd_ctx matches 1.. if score #r7 dd_ctx < #have7 dd_ctx if score #have7 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r7 dd_ctx matches 1.. if score #r7 dd_ctx < #have7 dd_ctx if score #have7 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r7 dd_ctx matches 1.. if score #r7 dd_ctx < #have7 dd_ctx if score #have7 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r8 dd_ctx matches 1.. if score #r8 dd_ctx < #have8 dd_ctx if score #have8 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r8 dd_ctx matches 1.. if score #r8 dd_ctx < #have8 dd_ctx if score #have8 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r8 dd_ctx matches 1.. if score #r8 dd_ctx < #have8 dd_ctx if score #have8 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r9 dd_ctx matches 1.. if score #r9 dd_ctx < #have9 dd_ctx if score #have9 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r9 dd_ctx matches 1.. if score #r9 dd_ctx < #have9 dd_ctx if score #have9 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r9 dd_ctx matches 1.. if score #r9 dd_ctx < #have9 dd_ctx if score #have9 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r10 dd_ctx matches 1.. if score #r10 dd_ctx < #have10 dd_ctx if score #have10 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r10 dd_ctx matches 1.. if score #r10 dd_ctx < #have10 dd_ctx if score #have10 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r10 dd_ctx matches 1.. if score #r10 dd_ctx < #have10 dd_ctx if score #have10 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r11 dd_ctx matches 1.. if score #r11 dd_ctx < #have11 dd_ctx if score #have11 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r11 dd_ctx matches 1.. if score #r11 dd_ctx < #have11 dd_ctx if score #have11 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r11 dd_ctx matches 1.. if score #r11 dd_ctx < #have11 dd_ctx if score #have11 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r12 dd_ctx matches 1.. if score #r12 dd_ctx < #have12 dd_ctx if score #have12 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r12 dd_ctx matches 1.. if score #r12 dd_ctx < #have12 dd_ctx if score #have12 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r12 dd_ctx matches 1.. if score #r12 dd_ctx < #have12 dd_ctx if score #have12 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r13 dd_ctx matches 1.. if score #r13 dd_ctx < #have13 dd_ctx if score #have13 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r13 dd_ctx matches 1.. if score #r13 dd_ctx < #have13 dd_ctx if score #have13 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r13 dd_ctx matches 1.. if score #r13 dd_ctx < #have13 dd_ctx if score #have13 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r14 dd_ctx matches 1.. if score #r14 dd_ctx < #have14 dd_ctx if score #have14 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r14 dd_ctx matches 1.. if score #r14 dd_ctx < #have14 dd_ctx if score #have14 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r14 dd_ctx matches 1.. if score #r14 dd_ctx < #have14 dd_ctx if score #have14 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r15 dd_ctx matches 1.. if score #r15 dd_ctx < #have15 dd_ctx if score #have15 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r15 dd_ctx matches 1.. if score #r15 dd_ctx < #have15 dd_ctx if score #have15 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r15 dd_ctx matches 1.. if score #r15 dd_ctx < #have15 dd_ctx if score #have15 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r16 dd_ctx matches 1.. if score #r16 dd_ctx < #have16 dd_ctx if score #have16 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r16 dd_ctx matches 1.. if score #r16 dd_ctx < #have16 dd_ctx if score #have16 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r16 dd_ctx matches 1.. if score #r16 dd_ctx < #have16 dd_ctx if score #have16 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #r17 dd_ctx matches 1.. if score #r17 dd_ctx < #have17 dd_ctx if score #have17 dd_ctx matches 2 run scoreboard players add #bot_cost dd_ctx 18
execute if score #r17 dd_ctx matches 1.. if score #r17 dd_ctx < #have17 dd_ctx if score #have17 dd_ctx matches 3 run scoreboard players add #bot_cost dd_ctx 28
execute if score #r17 dd_ctx matches 1.. if score #r17 dd_ctx < #have17 dd_ctx if score #have17 dd_ctx matches 4 run scoreboard players add #bot_cost dd_ctx 160
execute if score #have16 dd_ctx matches 1 if score #have17 dd_ctx matches 1 unless score #r16 dd_ctx = #r17 dd_ctx run scoreboard players add #bot_cost dd_ctx 180
execute if score #type dd_ctx matches 11..13 run scoreboard players add #bot_cost dd_ctx 130
execute if score #type dd_ctx matches 14 run scoreboard players add #bot_cost dd_ctx 180
# 对手报单/报双时，单张/对子尽可能用大牌拦截。
execute if score #bot_type dd_ctx matches 1.. if score #bot_enemy_min dd_ctx matches 1 if score #type dd_ctx matches 1 run function doudizhu:bot/emergency
execute if score #bot_type dd_ctx matches 1.. if score #bot_enemy_min dd_ctx matches 2 if score #type dd_ctx matches 2 run function doudizhu:bot/emergency
execute if score #bot_type dd_ctx matches 0 run function doudizhu:bot/lead_strategy
# 能一手出完时优先级最高，不受保炸或拆牌惩罚影响。
execute if score #n dd_ctx = #bot_total dd_ctx run scoreboard players set #bot_cost dd_ctx -100000
