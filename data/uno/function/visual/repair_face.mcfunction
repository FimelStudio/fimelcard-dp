# 旧版已落桌的牌原位翻面；保留实体、牌型、座位、发光、平移XZ和座位朝向。
execute unless entity @s[type=minecraft:item_display,tag=un.face] run return 0
data modify entity @s transformation.right_rotation set value [0f,1f,0f,0f]
data modify entity @s transformation.translation[1] set value 0.040625f
tag @s add un.face_up_v2
