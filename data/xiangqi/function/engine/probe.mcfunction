$scoreboard players set #to xq_ctx $(to)
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #found xq_ctx 1
