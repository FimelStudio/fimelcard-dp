tag @s add ca.deck_direct
scoreboard players operation @s ct_id = #table ca_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:catan/development_deck"}},item_display:"none",brightness:{block:15,sky:15},transformation:{translation:[0f,0.15f,0f],scale:[0.3f,0.3f,0.3f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
execute if score #deck_orient ca_ctx matches 1 run data modify entity @s transformation.left_rotation set value [0f,-0.7071068f,0f,0.7071068f]
