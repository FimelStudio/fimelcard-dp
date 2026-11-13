kill @e[tag=ca.look_ray]
tag @a[tag=ca.look_actor] remove ca.look_actor
tag @s add ca.look_actor
scoreboard players set #look_side ca_ctx -1
scoreboard players set #look_steps ca_ctx 32
execute anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add ca.look_ray
data modify entity @e[tag=ca.look_ray,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=ca.look_ray,limit=1] at @s run function catan:direct/look_step
kill @e[tag=ca.look_ray]
tag @s remove ca.look_actor
