$scoreboard players set #from ch_ctx $(from)
$scoreboard players set #to ch_ctx $(to)
function chess:engine/check_move
execute if score #legal ch_ctx matches 1 run scoreboard players set #found ch_ctx 1
