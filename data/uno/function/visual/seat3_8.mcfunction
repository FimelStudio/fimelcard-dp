tag @s add un.visual
tag @s add un.face
tag @s add un.face_up_v2
scoreboard players operation @s ct_id = #vis_table un_ctx
scoreboard players set @s un_seat 3
# 仅桌面牌：right_Y180抵消客户端固有Y180；seatYaw*X90把north正面朝+Y。
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:uno/$(model)"}},item_display:"none",transformation:{translation:[0.0406250f,0.0406250f,0.0406250f],left_rotation:[0.5000000f,-0.5000000f,0.5000000f,0.5000000f],right_rotation:[0f,1f,0f,0f],scale:[0.65f,0.65f,0.65f]},Glowing:1b,glow_color_override:16766720,brightness:{block:15,sky:15},view_range:24f,shadow_radius:0f}
