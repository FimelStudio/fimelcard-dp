scoreboard players operation #ray_mid go_ctx = #ray_low go_ctx
scoreboard players operation #ray_mid go_ctx += #ray_high go_ctx
scoreboard players set #ray_two go_ctx 2
scoreboard players operation #ray_mid go_ctx /= #ray_two go_ctx
function weiqi:input/ray_probe
execute if score #ray_below go_ctx matches 1 run scoreboard players operation #ray_high go_ctx = #ray_mid go_ctx
execute if score #ray_below go_ctx matches 0 run scoreboard players operation #ray_low go_ctx = #ray_mid go_ctx
scoreboard players remove #ray_count go_ctx 1
execute if score #ray_count go_ctx matches 1.. run function weiqi:input/ray_bisect
