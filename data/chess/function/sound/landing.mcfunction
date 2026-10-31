execute if score @s ch_check matches 1 run return run function chess:sound/check
scoreboard players set #sound_rook ch_ctx -1
scoreboard players set #sound_captured ch_ctx 0
execute store result score #sound_rook ch_ctx run data get entity @s data.chess.last.rook_from
execute store result score #sound_captured ch_ctx run data get entity @s data.chess.last.captured
execute if score #sound_rook ch_ctx matches 0..63 run return run function chess:sound/castle
execute unless score #sound_captured ch_ctx matches 0 run return run function chess:sound/capture
function chess:sound/move
