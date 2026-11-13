execute store result score #reply gm_ctx run data get entity @s data.gomoku.ai.reply
execute store result score #value gm_ctx run data get entity @s data.gomoku.ai.root_score
scoreboard players set #two gm_ctx 2
scoreboard players operation #reply gm_ctx *= #two gm_ctx
scoreboard players operation #value gm_ctx -= #reply gm_ctx
execute store result score #best gm_ctx run data get entity @s data.gomoku.ai.best
execute if score #value gm_ctx > #best gm_ctx run function gomoku:ai/better_reply
execute store result score #root gm_ctx run data get entity @s data.gomoku.ai.root
scoreboard players add #root gm_ctx 1
execute store result entity @s data.gomoku.ai.root int 1 run scoreboard players get #root gm_ctx
execute if score #root gm_ctx matches 3.. run return run function gomoku:ai/submit
function gomoku:ai/prepare_reply
