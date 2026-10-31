function xiangqi:system/context
function xiangqi:engine/cache
scoreboard players set #legal xq_ctx 0
execute unless score @s xq_state matches 1 run return 0
function xiangqi:engine/check_move
execute unless score #legal xq_ctx matches 1 run return 0
function xiangqi:engine/commit
return 1
