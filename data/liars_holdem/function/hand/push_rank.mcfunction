# 把一个存在的点数写入第一个仍为0的比较键；同一点数每次只写一格
scoreboard players set #pushed lh_ctx 0
$execute if score $(source) lh_ctx matches 1.. if score @s lh_k1 matches 0 run scoreboard players set @s lh_k1 $(rank)
$execute if score $(source) lh_ctx matches 1.. if score @s lh_k1 matches $(rank) run scoreboard players set #pushed lh_ctx 1
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k2 matches 0 run scoreboard players set @s lh_k2 $(rank)
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k2 matches $(rank) run scoreboard players set #pushed lh_ctx 1
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k3 matches 0 run scoreboard players set @s lh_k3 $(rank)
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k3 matches $(rank) run scoreboard players set #pushed lh_ctx 1
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k4 matches 0 run scoreboard players set @s lh_k4 $(rank)
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k4 matches $(rank) run scoreboard players set #pushed lh_ctx 1
$execute if score #pushed lh_ctx matches 0 if score $(source) lh_ctx matches 1.. if score @s lh_k5 matches 0 run scoreboard players set @s lh_k5 $(rank)
