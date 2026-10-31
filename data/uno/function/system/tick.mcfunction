scoreboard players add @s un_clock 1
execute if score @s un_clock matches 20.. run function uno:system/check_online
execute unless entity @s[tag=un.controller] run return 0
execute if data entity @s data.uno.deal_queue[0] run function uno:animation/tick
# 正常回合和质疑没有倒计时，不逐刻扫描手牌或重建界面。
execute if score @s un_state matches 2 run return 0
execute if score @s un_state matches 4 run return 0
function uno:system/context
execute if score @s un_state matches 1 run return run function uno:round/deal_tick
execute if score @s un_state matches 3 run return run function uno:round/uno_tick
execute if score @s un_state matches 5 run function uno:round/result_tick
