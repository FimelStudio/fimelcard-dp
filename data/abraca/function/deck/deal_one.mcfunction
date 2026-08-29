# 执行者为牌桌控制器；标记与背包物品立即成为权威手牌，飞行纸牌只负责动画。
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @e[type=minecraft:marker,tag=ab.deck,sort=random,limit=1] if score @s ab_id = #ctx ab_ctx run tag @s add ab.drawn
execute unless entity @e[tag=ab.drawn,limit=1] run return fail
execute as @e[tag=ab.drawn,limit=1] run scoreboard players operation @s ab_owner = @a[tag=ab.deal_receiver,limit=1] ab_seat
execute as @e[tag=ab.drawn,limit=1] run tag @s remove ab.deck
execute as @e[tag=ab.drawn,limit=1] run tag @s add ab.hand
give @a[tag=ab.deal_receiver,limit=1] minecraft:paper[minecraft:item_model='card:abraca/back',minecraft:item_name='未知咒语石',minecraft:custom_data={abraca:{stone:1b}},minecraft:max_stack_size=1]
function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model='card:abraca/back',minecraft:item_name='未知咒语石',minecraft:custom_data={abraca:{visual:1b}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get @a[tag=ab.deal_receiver,limit=1] ab_seat
function cardtable:animation/deal/launch with storage cardtable:deal
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
execute as @a[tag=ab.deal_receiver] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.deal_receiver
