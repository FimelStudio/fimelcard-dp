scoreboard players operation #score gm_ctx = #own gm_ctx
scoreboard players operation #score gm_ctx += #own gm_ctx
scoreboard players operation #score gm_ctx += #enemy gm_ctx
scoreboard players operation #score gm_ctx += #random gm_ctx
execute if score @s gm_level matches 3 if score #ownfork gm_ctx matches 2.. run scoreboard players add #score gm_ctx 200000
execute if score @s gm_level matches 3 if score #fork gm_ctx matches 2.. run scoreboard players add #score gm_ctx 150000
