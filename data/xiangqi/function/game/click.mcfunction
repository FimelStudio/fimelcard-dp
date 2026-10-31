function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute unless score @e[tag=xq.actor,limit=1] xq_side = @s xq_turn run return 0
execute unless score #target xq_ctx matches 0..89 run return 0
scoreboard players set #chosen xq_ctx 0
execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx run scoreboard players operation #chosen xq_ctx = @s xq_piece
scoreboard players operation #chosen xq_ctx *= @s xq_turn
execute if score #chosen xq_ctx matches 1..7 run return run function xiangqi:game/select
execute if score @s xq_sel matches -1 run return 0
scoreboard players operation #from xq_ctx = @s xq_sel
scoreboard players operation #to xq_ctx = #target xq_ctx
function xiangqi:game/snapshot
function xiangqi:engine/try_move
execute if score #legal xq_ctx matches 0 run function xiangqi:game/illegal
