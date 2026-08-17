# 将现有桌椅注册成通用牌桌：不放置table4结构，也不会修改任何方块
# 玩家站在3×3桌面的中心方块上执行；向下1格即为桌面方块层
# 四个座位锚点仍位于桌心南北东西各2格
execute unless entity @s[type=minecraft:player] run return fail
tag @s add ct.create_no_blocks
execute positioned ~ ~-1 ~ run function cardtable:admin/create
tag @s remove ct.create_no_blocks
