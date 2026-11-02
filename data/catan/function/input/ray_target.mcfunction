scoreboard players set #ray_low ca_ctx 0
scoreboard players set #ray_high ca_ctx 32768
scoreboard players set #ray_count ca_ctx 14
function catan:input/x_bisect
scoreboard players operation #x ca_ctx = #ray_low ca_ctx
scoreboard players remove #x ca_ctx 16384
scoreboard players set #ray_low ca_ctx 0
scoreboard players set #ray_high ca_ctx 32768
scoreboard players set #ray_count ca_ctx 14
function catan:input/z_bisect
scoreboard players operation #z ca_ctx = #ray_low ca_ctx
scoreboard players remove #z ca_ctx 16384
execute if entity @e[tag=ca.current,scores={ca_orient=1},limit=1] run function catan:input/unrotate
scoreboard players set #target ca_ctx -1
scoreboard players set #best ca_ctx 2147483647
scoreboard players operation #mode ca_ctx = @s ca_mode
execute if entity @e[tag=ca.current,scores={ct_capacity=4},limit=1] run function catan:input/pick4
execute if entity @e[tag=ca.current,scores={ct_capacity=8},limit=1] run function catan:input/pick8
execute if score #target ca_ctx matches 0.. run scoreboard players set #ray_ok ca_ctx 1
