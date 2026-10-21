# 每个真人回合只探测一次；重载保留倒计时，旧局缺失分数时补查。
execute unless score @s dd_autopass matches -1..100 run scoreboard players set @s dd_autopass -1
execute if score @s dd_autopass matches -1 run return run function doudizhu:autopass/start
execute unless score @s dd_autopass matches 1..100 run return 0
execute unless score @s dd_turn = @s dd_auto_seat run return run function doudizhu:autopass/start
scoreboard players remove @s dd_autopass 1
execute if score @s dd_autopass matches 0 run function doudizhu:autopass/finish
