execute unless score #remaining ma_ctx matches 1.. run return 0
execute unless score #walk_budget ma_ctx matches 1.. run return 0
scoreboard players remove #walk_budget ma_ctx 1
scoreboard players operation #destination ma_ctx += #direction ma_ctx
execute if score #destination ma_ctx matches ..0 run scoreboard players set #destination ma_ctx 0
execute if score #destination ma_ctx matches 30.. run return 0
scoreboard players set #occupied ma_ctx 0
execute unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1
execute if score #occupied ma_ctx matches 1 run scoreboard players add #jumped ma_ctx 1
execute if score #occupied ma_ctx matches 0 run scoreboard players remove #remaining ma_ctx 1
execute if score #destination ma_ctx matches 0 run return 0
function magical_athlete:engine/move/leap_step
