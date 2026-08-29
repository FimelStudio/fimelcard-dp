# 执行者为牌桌控制器；#seat 已由 deck/draw 写入本次补牌的目标座位。
scoreboard players operation #deal_seat ab_ctx = #seat ab_ctx
function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model='card:abraca/back',minecraft:item_name='未知咒语石',minecraft:custom_data={abraca:{visual:1b}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get #deal_seat ab_ctx
function cardtable:animation/deal/launch with storage cardtable:deal
