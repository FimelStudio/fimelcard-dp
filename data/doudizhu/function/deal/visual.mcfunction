function doudizhu:player/audience
# 公共飞牌只飞向真人；权威牌组仍向三名参与者各发17张。
scoreboard players set #real_target dd_ctx 0
function doudizhu:deal/visual_target
execute unless score #real_target dd_ctx matches 1 run return run function doudizhu:bot/clear_actors
function cardtable:animation/deal/spawn_card
# 发牌表现统一使用双面牌背，避免露出无关的小丑牌面。
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:poker/back",minecraft:custom_data={doudizhu:{visual:1b}}]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
function cardtable:animation/deal/launch with storage cardtable:deal
function cardtable:animation/deal/sound
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
