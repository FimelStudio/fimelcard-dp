# 飞行实体仅表示一张牌，不携带真实身份，旁观者也只能看到牌背。
$item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:love_letter/back",minecraft:item_name="情书",minecraft:custom_data={love_letter:{visual:1b,table:$(table)}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
