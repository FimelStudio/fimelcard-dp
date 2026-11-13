# 八人桌内部初始化；由创建入口以新控制器为执行者调用，玩家无需直接执行。
tag @s add ct.controller
scoreboard players set @s ct_capacity 8
execute if entity @a[tag=ct.creator,tag=ct.create_no_blocks,limit=1] run tag @s add ct.no_structure
function cardtable:table/init
tellraw @a[tag=ct.creator,limit=1] [{text:"[牌桌] 已创建八人牌桌 #",color:"green"},{score:{name:"@s",objective:"ct_id"}},{text:"，桌面4×4，每边两座。可在菜单选择全部11款游戏，实际开局人数按各游戏规则限制；UNO支持2～8人。"}]
execute if entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] {text:"现有桌模式：只添加座位及菜单，未修改方块。",color:"gray"}
tag @s remove ct.no_structure
