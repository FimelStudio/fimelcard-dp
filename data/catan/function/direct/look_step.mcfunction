execute as @a[tag=ca.audience,tag=!ca.look_actor] at @s positioned ~ ~1 ~ if entity @e[tag=ca.look_ray,distance=..0.7,limit=1] run scoreboard players operation #look_side ca_ctx = @s ca_side
execute if score #look_side ca_ctx matches 1..4 run return 0
scoreboard players remove #look_steps ca_ctx 1
execute unless score #look_steps ca_ctx matches 1.. run return 0
tp @s ^ ^ ^0.3
execute at @s run function catan:direct/look_step
