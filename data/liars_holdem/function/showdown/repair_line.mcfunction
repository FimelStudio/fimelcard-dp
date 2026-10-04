# 兼容旧世界坐标双列和上一版局部变换双列；保留文字、缩放及所有牌局分数。
execute store result score #layout_delta_x lh_ctx run data get entity @s Pos[0] 1
scoreboard players operation #layout_delta_x lh_ctx -= #layout_center_x lh_ctx
execute store result score #layout_local_x lh_ctx run data get entity @s transformation.translation[0] 100
scoreboard players set #layout_row lh_ctx 0
execute if score #layout_delta_x lh_ctx matches ..-1 run scoreboard players set #layout_row lh_ctx 1
execute if score #layout_local_x lh_ctx matches ..-1 run scoreboard players set #layout_row lh_ctx 1
execute if score #layout_delta_x lh_ctx matches 1.. run scoreboard players set #layout_row lh_ctx 2
execute if score #layout_local_x lh_ctx matches 1.. run scoreboard players set #layout_row lh_ctx 2
# 左列保留高度，右列接在其上方；原本居中的排名按实际亮牌人数上移。
$execute if score #layout_row lh_ctx matches 1 run tp @s $(x) ~ $(z)
$execute if score #layout_row lh_ctx matches 2 run tp @s $(x) ~2.20 $(z)
$execute if score #layout_row lh_ctx matches 0 run tp @s $(x) ~$(rank_rise) $(z)
data modify entity @s transformation.translation set value [0f,0f,0f]
tag @s add lh.showdown_single
