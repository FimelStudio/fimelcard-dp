# 单桌持久队列，每两刻一张；正常出牌/等待质疑时也继续播放。
execute unless score @s un_anim_wait matches 0..1 run scoreboard players set @s un_anim_wait 0
execute if score @s un_anim_wait matches 1 run return run scoreboard players remove @s un_anim_wait 1
execute unless data entity @s data.uno.deal_queue[0] run return 0
data modify storage uno:animation launch set from entity @s data.uno.deal_queue[0]
execute store result storage uno:animation launch.table int 1 run scoreboard players get @s ct_id
data modify storage cardtable:deal seat set from storage uno:animation launch.seat
function uno:deck/animate with storage uno:animation launch
data remove entity @s data.uno.deal_queue[0]
scoreboard players set @s un_anim_wait 1
