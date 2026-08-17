# Fast Card设置属于牌桌上的Fast Card模块；切换其他游戏不会覆盖这些数值
execute unless score @s fc_max matches 1..999 run scoreboard players set @s fc_max 5
execute unless score @s fc_rule matches 0..1 run scoreboard players set @s fc_rule 0

# 这些都是运行期状态，只在大厅初始化或重新选择Fast Card时归零
scoreboard players set @s fc_round 0
scoreboard players set @s fc_timer 0
scoreboard players set @s fc_press 0
scoreboard players set @s fc_state 0
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_deal 0
