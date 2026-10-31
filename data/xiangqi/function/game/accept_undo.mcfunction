function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute if score @s xq_undo matches 0 run return 0
execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_undo run return 0
execute unless data entity @s data.xiangqi.undo run return 0
function xiangqi:game/restore_undo
