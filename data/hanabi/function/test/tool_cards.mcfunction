# 仅用于检查资源包牌面，不会创建权威手牌或影响正在进行的牌局
give @s minecraft:paper[minecraft:item_model="card:hanabi/tool_hint",minecraft:item_name="提示牌（资源测试）",minecraft:max_stack_size=1]
give @s minecraft:paper[minecraft:item_model="card:hanabi/tool_restore",minecraft:item_name="恢复牌（资源测试）",minecraft:max_stack_size=1]
tellraw @s [{text:"[花火测试] ",color:"light_purple"},{text:"已给予提示牌和恢复牌的资源测试物品。",color:"green"}]
