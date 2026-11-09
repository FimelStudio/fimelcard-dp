tag @s add ca.deck_direct
scoreboard players operation @s ct_id = #table ca_ctx
data merge entity @s {item:{id:"minecraft:book",count:1},item_display:"fixed",brightness:{block:15,sky:15},transformation:{scale:[0.4f,0.4f,0.4f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f]}}
