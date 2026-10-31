# 末张 +2/+4 的补牌先逐张飞完，再进入小局结算倒计时。
execute if data entity @s data.uno.deal_queue[0] run return 0
scoreboard players remove @s un_timer 1
execute if score @s un_timer matches 1.. run return 0
execute if score @s un_matchend matches 1 run return run function uno:game/finish
function uno:round/start
