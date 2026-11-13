# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #ray_mid ca_ctx = #ray_low ca_ctx
scoreboard players operation #ray_mid ca_ctx += #ray_high ca_ctx
scoreboard players set #ray_two ca_ctx 2
scoreboard players operation #ray_mid ca_ctx /= #ray_two ca_ctx
function catan:input/ray_probe
execute if score #ray_below ca_ctx matches 1 run scoreboard players operation #ray_high ca_ctx = #ray_mid ca_ctx
execute if score #ray_below ca_ctx matches 0 run scoreboard players operation #ray_low ca_ctx = #ray_mid ca_ctx
scoreboard players remove #ray_count ca_ctx 1
execute if score #ray_count ca_ctx matches 1.. run function catan:input/ray_bisect
