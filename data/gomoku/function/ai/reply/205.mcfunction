scoreboard players operation #stone gm_ctx = #side gm_ctx
scoreboard players operation #stone gm_ctx *= #minus gm_ctx
function gomoku:ai/shape/205
execute if score #fork gm_ctx matches 2.. run scoreboard players add #shape gm_ctx 200000
execute store result score #reply gm_ctx run data get entity @s data.gomoku.ai.reply
execute if score #shape gm_ctx > #reply gm_ctx store result entity @s data.gomoku.ai.reply int 1 run scoreboard players get #shape gm_ctx
