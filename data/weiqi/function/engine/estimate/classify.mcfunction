# 三路内且至少近两步才暂归属，未定点不加入任何一方估计面积。
scoreboard players operation @s go_owner = @s go_piece
execute unless score @s go_piece matches 0 run return 0
scoreboard players operation #est_gap go_ctx = @s go_wdist
scoreboard players operation #est_gap go_ctx -= @s go_bdist
execute if score @s go_bdist matches ..3 if score #est_gap go_ctx matches 2.. run scoreboard players set @s go_owner 1
execute if score @s go_wdist matches ..3 if score #est_gap go_ctx matches ..-2 run scoreboard players set @s go_owner -1
