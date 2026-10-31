function uno:system/context
execute unless data entity @s data.uno.deal_queue run data modify entity @s data.uno.deal_queue set value []
execute unless score @s un_anim_wait matches 0..1 run scoreboard players set @s un_anim_wait 0
# 迁移旧临时牌盒，只补回桌心常驻盒，保留出牌、待发队列和飞行牌。
function cardtable:animation/deal/box/clear
function uno:visual/ensure_box
function uno:visual/repair_faces
function uno:system/advance
execute as @a[tag=un.audience] run function uno:input/give
tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{text:'数据包已重新加载，牌局与计时已保留。按 Q 重新打开手牌。',color:'yellow'}]
