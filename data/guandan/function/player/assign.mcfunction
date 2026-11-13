tag @s add gd.assigned
scoreboard players operation @s gd_order = #assign gd_ctx
scoreboard players operation @s ct_seat = #assign gd_ctx
execute if score #cap gd_ctx matches 8 run scoreboard players operation @s ct_seat *= #two gd_ctx
scoreboard players add @s ct_seat 1
scoreboard players add #assign gd_ctx 1
