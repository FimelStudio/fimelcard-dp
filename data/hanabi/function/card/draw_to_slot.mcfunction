# #slot与#actor_seat由本回合动作保留；空牌库时手牌位保持空缺
execute unless score @s hb_deck_count matches 1.. run execute as @a[tag=hb.action_actor,limit=1] run function hanabi:ui/player/rebuild
execute unless score @s hb_deck_count matches 1.. run return 0
function hanabi:deck/select_random
execute unless entity @e[tag=hb.drawn,limit=1] run return fail
scoreboard players operation @e[tag=hb.drawn,limit=1] hb_seat = #actor_seat hb_ctx
scoreboard players operation @e[tag=hb.drawn,limit=1] hb_slot = #slot hb_ctx
scoreboard players set @e[tag=hb.drawn,limit=1] hb_known_c 0
scoreboard players set @e[tag=hb.drawn,limit=1] hb_known_n 0
tag @e[tag=hb.drawn,limit=1] remove hb.deck
tag @e[tag=hb.drawn,limit=1] add hb.hand
scoreboard players remove @s hb_deck_count 1

# 抽牌仍播放通用牌盒飞行动画；飞行物仅负责表现，落牌后由权威标记生成真实手牌物品
function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model="card:hanabi/back",minecraft:item_name="花火牌背",minecraft:custom_data={hanabi:{visual:1b}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
execute store result storage cardtable:deal seat int 1 run scoreboard players get #actor_seat hb_ctx
function cardtable:animation/deal/launch with storage cardtable:deal
function cardtable:animation/deal/sound
execute as @a[tag=hb.action_actor,limit=1] run function hanabi:ui/player/rebuild
tag @e[tag=hb.drawn] remove hb.drawn

# 普通牌库耗尽后不再补牌；牌局会继续到所有普通手牌全部处理完
