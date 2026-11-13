scoreboard players set #ordered dd_ctx 0
execute store result score #queue_len dd_ctx run data get storage doudizhu:deck queue
execute if score @s dd_noshuffle matches 1 unless score #queue_len dd_ctx matches 54 run function doudizhu:deck/seed_groups
execute store result score #queue_len dd_ctx run data get storage doudizhu:deck queue
execute unless score #queue_len dd_ctx matches 54 run return 0
scoreboard players set #ordered dd_ctx 1
execute store result score #cut dd_ctx run random value 1..53
function doudizhu:deck/cut
scoreboard players set #position dd_ctx 0
function doudizhu:deck/assign
scoreboard players set #dealpos dd_ctx 0
