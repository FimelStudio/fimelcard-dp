# 随机牌标记是权威数据；飞向玩家的纸牌只承担动画
function hanabi:deck/select_random
execute unless entity @e[tag=hb.drawn,limit=1] run return fail

scoreboard players add @a[tag=hb.deal_receiver,limit=1] hb_hand_count 1
scoreboard players operation #hand_slot hb_ctx = @a[tag=hb.deal_receiver,limit=1] hb_hand_count
scoreboard players operation @e[tag=hb.drawn,limit=1] hb_seat = @s hb_scan
scoreboard players operation @e[tag=hb.drawn,limit=1] hb_slot = #hand_slot hb_ctx
scoreboard players set @e[tag=hb.drawn,limit=1] hb_known_c 0
scoreboard players set @e[tag=hb.drawn,limit=1] hb_known_n 0
tag @e[tag=hb.drawn,limit=1] remove hb.deck
tag @e[tag=hb.drawn,limit=1] add hb.hand
scoreboard players remove @s hb_deck_count 1

function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model="card:hanabi/back",minecraft:item_name="花火牌背",minecraft:custom_data={hanabi:{visual:1b}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get @s hb_scan
function cardtable:animation/deal/launch with storage cardtable:deal

execute as @a[tag=hb.deal_receiver,limit=1] run function hanabi:hand/sync
tag @e[tag=hb.drawn] remove hb.drawn
tag @a[tag=hb.deal_receiver] remove hb.deal_receiver
