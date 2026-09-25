# 候选题的正文只在私有界面出现；公共飞牌仅展示无文字牌背。
function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_name="候选题牌背",minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get @s wq_turn
function cardtable:animation/deal/launch with storage cardtable:deal
