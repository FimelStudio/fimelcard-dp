function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0
execute unless score #target ch_ctx matches 0..63 run return 0
scoreboard players set #chosen ch_ctx 0
execute as @e[type=minecraft:marker,tag=ch.board] if score @s ch_sq = #target ch_ctx run scoreboard players operation #chosen ch_ctx = @s ch_piece
scoreboard players operation #chosen ch_ctx *= @s ch_turn
execute if score #chosen ch_ctx matches 1..6 run return run function chess:game/select
execute if score @s ch_sel matches -1 run return 0
scoreboard players operation #from ch_ctx = @s ch_sel
scoreboard players operation #to ch_ctx = #target ch_ctx
scoreboard players set #promo ch_ctx 0
function chess:game/snapshot
function chess:engine/try_move
execute if score #legal ch_ctx matches 0 run function chess:game/illegal
execute if score #legal ch_ctx matches 2 run function chess:game/promotion_pending
