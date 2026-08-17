# 第十二版牌桌：四个座椅载具统一上移0.15格，改善玩家对桌面牌区的视野
execute unless data entity @s {data:{cardtable:{menu_version:11}}} run function cardtable:table/migrate_v11

# 以桌心重新定位，确保新旧牌桌得到完全一致的座位高度
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=1},distance=..2.3] ~ ~0.32 ~-2
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=2},distance=..2.3] ~2 ~0.32 ~
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=3},distance=..2.3] ~ ~0.32 ~2
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=4},distance=..2.3] ~-2 ~0.32 ~

data merge entity @s {data:{cardtable:{menu_version:12}}}
function cardtable:log {text:"牌桌第12版迁移完成：座椅载具已统一提高0.15格"}
