# 设置保存在控制器上，切换游戏和结束比赛不清除。
execute unless score @s dd_max matches 1..32 run scoreboard players set @s dd_max 1

execute unless score @s dd_audio matches 0..1 run scoreboard players set @s dd_audio 1
