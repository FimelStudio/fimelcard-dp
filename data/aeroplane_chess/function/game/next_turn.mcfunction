scoreboard players set @s ac_state 1
scoreboard players set @s ac_sixes 0
scoreboard players set @s ac_selected -1
scoreboard players set @s ac_wait 10
scoreboard players add @s ac_turn 1
scoreboard players operation @s ac_turn %= #four ac_ctx
function aeroplane_chess:game/ensure_turn
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
