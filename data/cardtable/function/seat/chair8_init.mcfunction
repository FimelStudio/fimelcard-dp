# 展示实体原点在方块角点，平移半格使座椅中心与交互实体重合。
tag @s add ct.part
tag @s add ct.chair8
scoreboard players operation @s ct_id = #seat_owner ct_ctx
scoreboard players operation @s ct_seat = #new_seat ct_ctx
data merge entity @s {transformation:{translation:[-0.5f,0f,-0.5f],scale:[1f,1f,1f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s ct_seat matches 1..2 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"north",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 3..4 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"east",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 5..6 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"south",half:"bottom",shape:"straight",waterlogged:"false"}}}
execute if score @s ct_seat matches 7..8 run data merge entity @s {block_state:{Name:"minecraft:birch_stairs",Properties:{facing:"west",half:"bottom",shape:"straight",waterlogged:"false"}}}
