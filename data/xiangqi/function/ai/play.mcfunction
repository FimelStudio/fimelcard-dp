execute unless score @s xq_aiepoch = @s xq_epoch run return run function xiangqi:ai/reset
execute unless score @s xq_turn = @s xq_bot run return run function xiangqi:ai/reset
execute unless score @s ct_state matches 1 run return run function xiangqi:ai/reset
execute unless score @s xq_state matches 1 run return run function xiangqi:ai/reset
execute store result score #ai_source xq_ctx run data get entity @s data.xiangqi.ai.winner.f
execute unless score #ai_source xq_ctx matches 0..89 run return run function xiangqi:ai/no_move
function xiangqi:game/snapshot
execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.winner.f
execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.winner.t
scoreboard players set #promo xq_ctx 5
function xiangqi:engine/try_move
execute unless score #legal xq_ctx matches 1 run function xiangqi:ai/reset
