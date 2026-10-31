execute unless score @s ct_state matches 1 run return run function gomoku:ai/reset
execute unless score @s gm_state matches 1 run return run function gomoku:ai/reset
execute unless score @s gm_result matches 0 run return run function gomoku:ai/reset
execute unless score @s gm_bot matches -1 unless score @s gm_bot matches 1 run return run function gomoku:ai/reset
execute unless score @s gm_turn = @s gm_bot run return run function gomoku:ai/reset
execute if score @s gm_aistate matches 1 unless score @s gm_aiepoch = @s gm_epoch run return run function gomoku:ai/reset
execute unless score @s gm_aistate matches 1 run return run function gomoku:ai/start
execute if score @s gm_aiwait matches 1.. run return run scoreboard players remove @s gm_aiwait 1
function gomoku:engine/cache
execute unless score #cache_ok gm_ctx matches 1 run return run function gomoku:ai/invalid
execute store result score #stage gm_ctx run data get entity @s data.gomoku.ai.stage
execute store result score #index gm_ctx run data get entity @s data.gomoku.ai.index
execute store result score #top0 gm_ctx run data get entity @s data.gomoku.ai.top[0].score
execute store result score #top1 gm_ctx run data get entity @s data.gomoku.ai.top[1].score
execute store result score #top2 gm_ctx run data get entity @s data.gomoku.ai.top[2].score
scoreboard players set #work gm_ctx 12
execute if score #stage gm_ctx matches 2 run function gomoku:ai/apply_root
function gomoku:ai/batch
execute store result entity @s data.gomoku.ai.index int 1 run scoreboard players get #index gm_ctx
execute if score #index gm_ctx matches 361.. run function gomoku:ai/advance
