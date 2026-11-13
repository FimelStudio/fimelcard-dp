# 只修正缺失或越界设置，活跃对局和有效设置保持原值。
execute unless score @s un_mode matches 0..2 run scoreboard players set @s un_mode 0
execute unless score @s un_rounds matches 1..32 run scoreboard players set @s un_rounds 3
execute unless score @s un_target matches 100..1000 run scoreboard players set @s un_target 500
execute unless score @s un_auto matches 0..1 run scoreboard players set @s un_auto 0
execute unless score @s un_challenge matches 0..1 run scoreboard players set @s un_challenge 1
execute unless score @s un_window matches 20..100 run scoreboard players set @s un_window 60
