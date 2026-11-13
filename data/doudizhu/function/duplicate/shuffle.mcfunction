scoreboard players remove #remaining dd_ctx 1
execute store result storage doudizhu:deck max int 1 run scoreboard players get #remaining dd_ctx
data modify storage doudizhu:deck index set value 0
execute if score #remaining dd_ctx matches 1.. run function doudizhu:duplicate/random_index with storage doudizhu:deck
function doudizhu:duplicate/pick_card with storage doudizhu:deck
execute if score #remaining dd_ctx matches 1.. run function doudizhu:duplicate/shuffle
