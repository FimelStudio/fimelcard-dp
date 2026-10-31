function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 3 run return 0
execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0
execute unless score #promo ch_ctx matches 2..5 run return 0
scoreboard players operation #from ch_ctx = @s ch_pfrom
scoreboard players operation #to ch_ctx = @s ch_pto
function chess:game/snapshot
function chess:engine/try_move
execute if score #legal ch_ctx matches 0 run scoreboard players set @s ch_state 1
execute if score #legal ch_ctx matches 0 run function chess:game/illegal
