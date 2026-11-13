scoreboard players operation #right ch_ctx = #castle ch_ctx
scoreboard players operation #right ch_ctx /= #four ch_ctx
scoreboard players operation #right ch_ctx %= #two ch_ctx
execute if score #right ch_ctx matches 1 run scoreboard players remove #castle ch_ctx 4
