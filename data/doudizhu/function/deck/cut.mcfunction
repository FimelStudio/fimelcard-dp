data modify storage doudizhu:deck queue append from storage doudizhu:deck queue[0]
data remove storage doudizhu:deck queue[0]
scoreboard players remove #cut dd_ctx 1
execute if score #cut dd_ctx matches 1.. run function doudizhu:deck/cut
