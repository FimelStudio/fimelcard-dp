function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute if score @s gm_undo matches 0 run return 0
execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_undo run return 0
execute unless data entity @s data.gomoku.undo run return 0
function gomoku:game/restore_undo
