# 清除重构前由展示实体组成的旧牌桌；只选择没有ct.controller标签的旧控制器
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=fc.controller,tag=!ct.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'附近没有旧版展示实体牌桌。',color:'yellow'}]
execute unless entity @e[type=minecraft:marker,tag=fc.controller,tag=!ct.controller,distance=..8,sort=nearest,limit=1] run return fail

tag @s add ct.remove_actor
execute as @e[type=minecraft:marker,tag=fc.controller,tag=!ct.controller,distance=..8,sort=nearest,limit=1] at @s run function cardtable:table/remove_legacy
tag @s remove ct.remove_actor
