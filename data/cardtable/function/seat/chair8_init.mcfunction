# 展示实体原点在方块角点，平移半格使座椅中心与交互实体重合。
tag @s add ct.part
tag @s add ct.chair8
scoreboard players operation @s ct_id = #seat_owner ct_ctx
scoreboard players operation @s ct_seat = #new_seat ct_ctx
data merge entity @s {transformation:{translation:[-0.5f,0f,-0.5f],scale:[1f,1f,1f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]},view_range:24f}
execute if score @s ct_seat matches 1..2 run data merge entity @s {block_state:{id:"minecraft:birch_stairs",properties:{facing:"north",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 3..4 run data merge entity @s {block_state:{id:"minecraft:birch_stairs",properties:{facing:"east",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 5..6 run data merge entity @s {block_state:{id:"minecraft:birch_stairs",properties:{facing:"south",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 7..8 run data merge entity @s {block_state:{id:"minecraft:birch_stairs",properties:{facing:"west",half:"bottom",shape:"straight",waterlogged:"false"}}}

# 关闭亮度覆盖，使用环境光照。
data remove entity @s brightness
