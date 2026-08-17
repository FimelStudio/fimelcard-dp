# 从剩余牌库随机取一张，并把牌标记转换为该玩家的权威手牌记录
function liars_holdem:deck/select_random
execute unless entity @e[tag=lh.drawn,limit=1] run return fail
scoreboard players operation @s lh_card = @e[tag=lh.drawn,limit=1] lh_card
function liars_holdem:card/load_definition

scoreboard players add @a[tag=lh.deal_receiver,limit=1] lh_hand_count 1
scoreboard players operation #hand_slot lh_ctx = @a[tag=lh.deal_receiver,limit=1] lh_hand_count
scoreboard players operation @e[tag=lh.drawn,limit=1] lh_seat = @s lh_scan
scoreboard players operation @e[tag=lh.drawn,limit=1] lh_slot = #hand_slot lh_ctx
tag @e[tag=lh.drawn,limit=1] remove lh.deck
tag @e[tag=lh.drawn,limit=1] add lh.hand_card

# 公共发牌模块负责实体、声音、飞行动量和兜底送达
function cardtable:animation/deal/spawn_card
execute store result storage liars_holdem:card slot int 1 run scoreboard players get #hand_slot lh_ctx
execute store result storage liars_holdem:card table int 1 run scoreboard players get @s lh_id

data modify storage liars_holdem:card def.table set from storage liars_holdem:card table
data modify storage liars_holdem:card def.slot set from storage liars_holdem:card slot
function liars_holdem:deal/configure_item with storage liars_holdem:card def
data remove storage liars_holdem:card def.table
data remove storage liars_holdem:card def.slot

function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get @s lh_scan
function cardtable:animation/deal/launch with storage cardtable:deal
function liars_holdem:sound/card_received

tag @e[tag=lh.drawn] remove lh.drawn
tag @a[tag=lh.deal_receiver] remove lh.deal_receiver
