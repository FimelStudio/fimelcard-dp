function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @e[tag=gm.actor,limit=1] gm_side = @s gm_turn run return 0
scoreboard players operation #to gm_ctx = #target gm_ctx
function gomoku:engine/check_move
execute unless score #legal gm_ctx matches 1 run return run function gomoku:game/illegal
function gomoku:game/snapshot
function gomoku:engine/try_move
