# 独立于人机的计时，从发牌完成开始；重载保留已用时间。
execute unless score @s dd_state matches 2 run return 0
execute unless score @s dd_bidmode matches 2 run return 0
execute unless score @s dd_speed_time matches 0.. run scoreboard players set @s dd_speed_time 0
scoreboard players add @s dd_speed_time 1
execute if score @s dd_speed_time matches 301.. run function doudizhu:bid/speed_timeout
