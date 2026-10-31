scoreboard players set #rep ch_ctx 0
$execute if data entity @s data.chess.history[{key:"$(key)"}] store result score #rep ch_ctx run data get entity @s data.chess.history[{key:"$(key)"}].count
scoreboard players add #rep ch_ctx 1
$execute unless data entity @s data.chess.history[{key:"$(key)"}] run data modify entity @s data.chess.history append value {key:"$(key)",count:0}
$execute store result entity @s data.chess.history[{key:"$(key)"}].count int 1 run scoreboard players get #rep ch_ctx
scoreboard players operation @s ch_repetition = #rep ch_ctx
