# 设置保存在控制器上，切换游戏和结束比赛不清除。
execute unless score @s dd_max matches 1..32 run scoreboard players set @s dd_max 1

execute unless score @s dd_audio matches 0..1 run scoreboard players set @s dd_audio 1

execute unless score @s dd_bidmode matches 0..2 run scoreboard players set @s dd_bidmode 0

execute unless score @s dd_counts matches 0..1 run scoreboard players set @s dd_counts 1

execute unless score @s dd_counter matches 0..1 run scoreboard players set @s dd_counter 0
