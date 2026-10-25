# 新建4×4桌面、每边两座的八人桌；桌面及座椅占地6×6。
execute unless entity @s[type=minecraft:player] run return fail
execute if entity @e[type=minecraft:marker,tag=ct.controller,distance=..5.99] run tellraw @s {text:"[牌桌] 附近已有牌桌，请至少间隔6格。",color:"red"}
execute if entity @e[type=minecraft:marker,tag=ct.controller,distance=..5.99] run return fail
tag @a[tag=ct.creator] remove ct.creator
tag @s add ct.creator
# 偶数边长的桌心对齐方块交界点；执行位置即为桌面方块层。
execute align xyz summon minecraft:marker run function cardtable:table/setup8
tag @s remove ct.creator
