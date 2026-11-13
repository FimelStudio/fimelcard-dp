execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.queue[0].f
execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.queue[0].t
data remove entity @s data.xiangqi.ai.queue[0]
scoreboard players set #promo xq_ctx 5
function xiangqi:engine/check_move
execute unless score #legal xq_ctx matches 1 run return 0
execute if score @s xq_level matches 1 run return run function xiangqi:ai/random_legal
function xiangqi:ai/score_move
function xiangqi:ai/consider
