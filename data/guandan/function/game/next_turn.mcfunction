scoreboard players operation #turn gd_ctx = @s gd_turn
execute as @e[tag=gd.board] if score @s gd_seat = #turn gd_ctx run scoreboard players operation #next_order gd_ctx = @s gd_order
scoreboard players set #next gd_ctx -1
function guandan:game/next_candidate
function guandan:game/next_candidate
function guandan:game/next_candidate
function guandan:game/next_candidate
execute if score #next gd_ctx matches 1..8 run scoreboard players operation @s gd_turn = #next gd_ctx
function guandan:clock/reset
function guandan:visual/refresh
