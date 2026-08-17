# 宏参数来自liars_holdem:card；slot是本玩家逻辑手牌位1或2
$item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] contents with minecraft:paper[minecraft:item_model="$(model)",minecraft:item_name="$(name)",minecraft:custom_data={liars_holdem:{card:1b,id:$(id),rank:$(rank),suit:$(suit),slot:$(slot),table:$(table)}},minecraft:max_stack_size=1]
