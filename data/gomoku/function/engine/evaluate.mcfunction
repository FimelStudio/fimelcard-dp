execute if score @s gm_result matches 1..3 run return 0
function gomoku:engine/cache
execute unless score #cache_ok gm_ctx matches 1 run return run function gomoku:engine/invalid
data modify entity @s data.gomoku.win set value []
execute unless data entity @s data.gomoku.last run return run function gomoku:engine/full
execute store result score #last gm_ctx run data get entity @s data.gomoku.last.sq
execute store result score #mover gm_ctx run data get entity @s data.gomoku.last.side
execute unless score #last gm_ctx matches 0..360 run return run function gomoku:engine/invalid
execute unless score #mover gm_ctx matches -1 unless score #mover gm_ctx matches 1 run return run function gomoku:engine/invalid
function gomoku:engine/dispatch_line with entity @s data.gomoku.last
execute if data entity @s data.gomoku.win[4] run scoreboard players set @s gm_reason 1
execute if data entity @s data.gomoku.win[4] if score #mover gm_ctx matches 1 run scoreboard players set @s gm_result 1
execute if data entity @s data.gomoku.win[4] if score #mover gm_ctx matches -1 run scoreboard players set @s gm_result 2
execute if score @s gm_result matches 0 run function gomoku:engine/full
