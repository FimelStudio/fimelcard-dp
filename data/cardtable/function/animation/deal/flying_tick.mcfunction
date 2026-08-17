# 正常情况下牌会在数刻内被Owner玩家拾取，只为仍存在的牌增加公共飞行计时
scoreboard players add @s ct_anim 1
execute if score @s ct_anim matches 6.. run function cardtable:animation/deal/ensure_delivery
