execute store result score #card dd_ctx run data get storage doudizhu:deck queue[0]
execute as @e[tag=dd.pool] if score @s dd_card = #card dd_ctx run scoreboard players operation @s dd_deckpos = #position dd_ctx
scoreboard players add #position dd_ctx 1
data remove storage doudizhu:deck queue[0]
execute if data storage doudizhu:deck queue[0] run function doudizhu:deck/assign
