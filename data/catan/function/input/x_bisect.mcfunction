# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #ray_mid ca_ctx = #ray_low ca_ctx
scoreboard players operation #ray_mid ca_ctx += #ray_high ca_ctx
scoreboard players operation #ray_mid ca_ctx /= #two ca_ctx
scoreboard players operation #offset ca_ctx = #ray_mid ca_ctx
scoreboard players remove #offset ca_ctx 16384
execute store result storage catan:ray offset double 0.000244140625 run scoreboard players get #offset ca_ctx
scoreboard players set #greater ca_ctx 0
function catan:input/x_probe with storage catan:ray
execute if score #greater ca_ctx matches 1 run scoreboard players operation #ray_low ca_ctx = #ray_mid ca_ctx
execute if score #greater ca_ctx matches 0 run scoreboard players operation #ray_high ca_ctx = #ray_mid ca_ctx
scoreboard players remove #ray_count ca_ctx 1
execute if score #ray_count ca_ctx matches 1.. run function catan:input/x_bisect
