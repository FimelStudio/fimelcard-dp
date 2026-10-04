# @s 就是刚生成的牌盒，先绑定标签和桌号，再设置模型。
tag @s add ct.deal_box
tag @s add ct.part
scoreboard players operation @s ct_id = #deal_box_owner ct_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:cardbox"}},item_display:"ground",transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.1f,0.1f,0.1f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},interpolation_duration:10,view_range:24f,brightness:{block:15,sky:15}}
