# 方块展示原点向西北各平移半格，与四人桌座位交互中心对齐。
tag @s add ct.part
tag @s add ct.chair4
scoreboard players operation @s ct_id = #seat_owner ct_ctx
scoreboard players operation @s ct_seat = #new_seat ct_ctx
data merge entity @s {transformation:{translation:[-0.5f,0f,-0.5f],scale:[1f,1f,1f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]},view_range:24f}
execute if score @s ct_seat matches 1 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"north",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 2 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"east",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 3 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"south",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 4 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"west",half:"bottom",shape:"straight",waterlogged:"false"}}}

# 关闭亮度覆盖，使用环境光照。
data remove entity @s brightness
