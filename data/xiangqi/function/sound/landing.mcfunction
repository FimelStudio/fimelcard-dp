execute if score @s xq_check matches 1 run return run function xiangqi:sound/check
scoreboard players set #sound_captured xq_ctx 0
execute store result score #sound_captured xq_ctx run data get entity @s data.xiangqi.last.captured
execute unless score #sound_captured xq_ctx matches 0 run return run function xiangqi:sound/capture
function xiangqi:sound/move
