tag @s add ct.controller
scoreboard players set @s ct_capacity 8
execute if entity @a[tag=ct.creator,tag=ct.create_no_blocks,limit=1] run tag @s add ct.no_structure
function cardtable:table/init
tellraw @a[tag=ct.creator,limit=1] [{text:"[牌桌] 已创建八人牌桌 #",color:"green"},{score:{name:"@s",objective:"ct_id"}},{text:"，桌面4×4，每边两座。可选择Fast Card（固定4人）、赌命德州扑克（最多8人）、花火或出包魔法师（最多5人）、问非所答、瞎掰王、谍报风云（最多8人）、临界点或骷髅牌（最多6人）。"}]
execute if entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] {text:"现有桌模式：只添加座位及菜单，未修改方块。",color:"gray"}
tag @s remove ct.no_structure
