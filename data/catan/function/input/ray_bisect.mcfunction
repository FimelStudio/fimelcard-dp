scoreboard players operation #ray_mid ca_ctx = #ray_low ca_ctx
scoreboard players operation #ray_mid ca_ctx += #ray_high ca_ctx
scoreboard players set #ray_two ca_ctx 2
scoreboard players operation #ray_mid ca_ctx /= #ray_two ca_ctx
function catan:input/ray_probe
execute if score #ray_below ca_ctx matches 1 run scoreboard players operation #ray_high ca_ctx = #ray_mid ca_ctx
execute if score #ray_below ca_ctx matches 0 run scoreboard players operation #ray_low ca_ctx = #ray_mid ca_ctx
scoreboard players remove #ray_count ca_ctx 1
execute if score #ray_count ca_ctx matches 1.. run function catan:input/ray_bisect
