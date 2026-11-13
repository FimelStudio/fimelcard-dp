scoreboard players operation #ctx dd_ctx = @s dd_id
function doudizhu:deck/prepare
execute store result score #queue_len dd_ctx run data get storage doudizhu:deck queue
execute unless score #queue_len dd_ctx matches 54 run function doudizhu:deck/seed_groups
execute store result score #cut dd_ctx run random value 1..53
function doudizhu:deck/cut
data modify entity @s data.dd_duplicate.deck set from storage doudizhu:deck queue
