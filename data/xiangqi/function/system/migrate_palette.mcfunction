# 旧版棋盘 2 为木色、1 为竹绿；按桌迁移，活跃棋局及其他设置不变。
execute if score @s xq_board matches 1 run scoreboard players set @s xq_board 0
execute if score @s xq_board matches 2 run scoreboard players set @s xq_board 1
execute unless score @s xq_board matches 0..1 run scoreboard players set @s xq_board 0
execute unless score @s xq_palette matches 0..1 run scoreboard players set @s xq_palette 0
data modify entity @s data.xiangqi.palette_version set value 2b
