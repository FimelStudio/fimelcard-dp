tag @s add ac.visual
tag @s add ac.die
scoreboard players operation @s ct_id = #vis_table ac_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/dice"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
