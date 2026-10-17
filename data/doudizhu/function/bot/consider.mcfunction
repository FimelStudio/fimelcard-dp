execute if score #type dd_ctx matches 0 run return 0
scoreboard players set #bot_legal dd_ctx 0
execute if score #bot_type dd_ctx matches 0 run scoreboard players set #bot_legal dd_ctx 1
execute if score #type dd_ctx = #bot_type dd_ctx if score #n dd_ctx = #bot_len dd_ctx if score #high dd_ctx > #bot_high dd_ctx run scoreboard players set #bot_legal dd_ctx 1
execute if score #type dd_ctx matches 13 if score #bot_type dd_ctx matches 1..12 run scoreboard players set #bot_legal dd_ctx 1
execute if score #type dd_ctx matches 14 if score #bot_type dd_ctx matches 1..13 run scoreboard players set #bot_legal dd_ctx 1
execute unless score #bot_legal dd_ctx matches 1 run return 0
# 能结束本局才压队友；普通情况下保留队友牌权。
execute if score #bot_friend dd_ctx matches 1 unless score #n dd_ctx = #bot_total dd_ctx run return 0
function doudizhu:bot/evaluate
execute unless score #bot_cost dd_ctx < #bot_best_cost dd_ctx run return 0
scoreboard players operation #bot_best_cost dd_ctx = #bot_cost dd_ctx
scoreboard players set #bot_found dd_ctx 1
tag @e[tag=dd.hand] remove dd.bot_best
tag @e[tag=dd.hand,scores={dd_selected=1}] add dd.bot_best
