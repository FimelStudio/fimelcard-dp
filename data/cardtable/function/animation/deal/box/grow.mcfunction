# 在10刻内把本桌牌盒从当前大小平滑放大到1倍
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=ct.deal_box,distance=..2.1] if score @s ct_id = #ctx_id ct_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.0f,1.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
