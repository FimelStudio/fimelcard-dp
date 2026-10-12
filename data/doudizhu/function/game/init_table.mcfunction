# 设置保存在控制器上，切换游戏和结束比赛不清除。
execute unless score @s dd_max matches 1..32 run scoreboard players set @s dd_max 1
