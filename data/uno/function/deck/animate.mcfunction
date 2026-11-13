# 后台先发真牌，公共动画只展示牌背，不泄露其他玩家的手牌。
function cardtable:animation/deal/spawn_card
$item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:uno/back",minecraft:custom_data={uno:{card:1b,table:$(table),idx:$(idx)}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
function cardtable:animation/deal/launch with storage cardtable:deal
