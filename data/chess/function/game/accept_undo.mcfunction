function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute if score @s ch_undo matches 0 run return 0
execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_undo run return 0
execute unless data entity @s data.chess.undo run return 0
function chess:game/restore_undo
