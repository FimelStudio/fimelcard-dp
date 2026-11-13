function xiangqi:system/context
function xiangqi:engine/cache
scoreboard players set @s xq_result 0
scoreboard players set @s xq_reason 0
execute unless score #cache_ok xq_ctx matches 1 run return run function xiangqi:engine/invalid_board
function xiangqi:engine/check_current
scoreboard players operation @s xq_check = #attacked xq_ctx
function xiangqi:engine/has_move
execute if score #found xq_ctx matches 0 run function xiangqi:engine/mate
execute unless score @s xq_result matches 0 run return 1
function xiangqi:engine/material
execute if score #dead xq_ctx matches 1 run function xiangqi:engine/draw {reason:3}
execute unless score @s xq_result matches 0 run return 1
execute if score @s xq_repetition matches 3.. run function xiangqi:engine/history/adjudicate
execute unless score @s xq_result matches 0 run return 1
execute if score @s xq_half matches 120.. run function xiangqi:engine/draw {reason:5}
return run scoreboard players get @s xq_result
