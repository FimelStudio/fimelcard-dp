execute store result score #groups dd_ctx run data get storage doudizhu:deck groups
scoreboard players remove #groups dd_ctx 1
execute store result storage doudizhu:deck draw.max int 1 run scoreboard players get #groups dd_ctx
function doudizhu:deck/random_group with storage doudizhu:deck draw
function doudizhu:deck/append_group with storage doudizhu:deck draw
execute if data storage doudizhu:deck groups[0] run function doudizhu:deck/pick_group
