scoreboard players set #jumped ma_ctx 0
scoreboard players set #minus ma_ctx -1
scoreboard players operation #remaining ma_ctx = #amount ma_ctx
scoreboard players set #direction ma_ctx 1
execute if score #remaining ma_ctx matches ..-1 run scoreboard players set #direction ma_ctx -1
execute if score #remaining ma_ctx matches ..-1 run scoreboard players operation #remaining ma_ctx *= #minus ma_ctx
scoreboard players operation #destination ma_ctx = #position ma_ctx
scoreboard players set #walk_budget ma_ctx 96
function magical_athlete:engine/move/leap_step
