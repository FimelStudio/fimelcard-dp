advancement revoke @s only abraca:click/played_pile
tag @s add ab.pile_actor
scoreboard players set #pile_found ab_ctx 0
execute if entity @e[type=minecraft:interaction,tag=ab.pile_button,distance=..6,sort=nearest,limit=1] run scoreboard players set #pile_found ab_ctx 1
execute as @e[type=minecraft:interaction,tag=ab.pile_button,distance=..6,sort=nearest,limit=1] run scoreboard players operation #ctx ab_ctx = @s ab_id
execute unless score #pile_found ab_ctx matches 1 run return 0
execute as @e[type=minecraft:marker,tag=ab.controller] if score @s ab_id = #ctx ab_ctx run function abraca:ui/open_pile
tag @s remove ab.pile_actor
