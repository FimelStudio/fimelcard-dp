# 只清本桌排队与公共飞行牌；UNO 常驻盒由 visual/clear 管理。
data remove entity @s data.uno.deal_queue
scoreboard players set @s un_anim_wait 0
function cardtable:animation/deal/clear
