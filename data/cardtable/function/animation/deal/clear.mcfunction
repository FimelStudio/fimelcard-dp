# 清理当前牌桌的公共发牌实体；游戏结束、异常中止或返回大厅时均可安全调用
scoreboard players operation #ctx_id ct_ctx = @s ct_id
function cardtable:animation/deal/box/clear
execute as @e[type=minecraft:item,tag=ct.dealt_card,distance=..6] if score @s ct_id = #ctx_id ct_ctx run kill @s
kill @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2]
tag @a[tag=ct.deal_receiver] remove ct.deal_receiver
