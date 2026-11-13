scoreboard players operation #stone gm_ctx = #side gm_ctx
function gomoku:ai/shape/122
scoreboard players operation #own gm_ctx = #shape gm_ctx
scoreboard players operation #ownfork gm_ctx = #fork gm_ctx
scoreboard players operation #stone gm_ctx *= #minus gm_ctx
function gomoku:ai/shape/122
scoreboard players operation #enemy gm_ctx = #shape gm_ctx
execute store result score #random gm_ctx run random value 0..100
scoreboard players operation #score gm_ctx = #random gm_ctx
execute if score @s gm_level matches 2.. run function gomoku:ai/strategic
execute if score #enemy gm_ctx matches 100000000.. run scoreboard players set #score gm_ctx 10000000
execute if score #own gm_ctx matches 100000000.. run scoreboard players set #score gm_ctx 100000000
