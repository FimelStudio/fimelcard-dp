tag @s add un.visual
tag @s add un.box
scoreboard players operation @s ct_id = #vis_table un_ctx
# 原盒中心(.1875,0,.0625)经X+90度及0.65缩放后补偿，底面高于桌面。
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:uno/box"}},item_display:"none",transformation:{translation:[-0.121875f,0.040625f,0f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],scale:[0.65f,0.65f,0.65f]},brightness:{block:15,sky:15},view_range:24f,shadow_radius:0f}
