tag @s add ma.direct
tag @s add ma.pool
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ma_did $(id)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/token/$(slug)"}},item_display:"none",brightness:{block:15,sky:15},transformation:{scale:[0.26f,0.26f,0.26f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
