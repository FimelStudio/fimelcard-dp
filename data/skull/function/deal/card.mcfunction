function cardtable:animation/deal/spawn_card
execute unless score @s sk_deal_slot matches 4 run item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model="card:skull/back",minecraft:item_name="花牌 · 万寿菊",minecraft:custom_data={skull:{visual:1b}},minecraft:max_stack_size=1]
execute if score @s sk_deal_slot matches 4 run item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model="card:skull/back",minecraft:item_name="骷髅牌 · 糖骷髅",minecraft:custom_data={skull:{visual:1b}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.visual_only
function cardtable:animation/deal/sound
execute store result storage cardtable:deal seat int 1 run scoreboard players get @s sk_deal_seat
function cardtable:animation/deal/launch with storage cardtable:deal
