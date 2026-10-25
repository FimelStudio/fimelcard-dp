# 第十一版牌桌：按空间归属修复旧座椅桌号，避免同一张空闲牌桌只有部分座位可加入。
execute unless data entity @s {data:{cardtable:{menu_version:10}}} run function cardtable:table/migrate_v10

# 默认四座都在桌心水平距离2格处；6格建桌间距保证2.3格内只会命中本桌座椅。
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[type=minecraft:interaction,tag=ct.seat,distance=..2.3] run scoreboard players operation @s ct_id = #ctx_id ct_ctx
scoreboard players set @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=1},distance=..2.3] ct_kind 11
scoreboard players set @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=2},distance=..2.3] ct_kind 12
scoreboard players set @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=3},distance=..2.3] ct_kind 13
scoreboard players set @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=4},distance=..2.3] ct_kind 14
execute as @e[type=minecraft:interaction,tag=ct.seat,distance=..2.3] run data merge entity @s {width:0.96f,height:0.372f,response:1b}

# 同步旧实体的位置；即使历史上有重叠座椅，也会落在相同且正确的乘坐高度。
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=1},distance=..2.3] ~ ~0.17 ~-2
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=2},distance=..2.3] ~2 ~0.17 ~
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=3},distance=..2.3] ~ ~0.17 ~2
tp @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=4},distance=..2.3] ~-2 ~0.17 ~

data merge entity @s {data:{cardtable:{menu_version:11}}}
function cardtable:log {text:"牌桌第11版迁移完成：已按空间归属修复座椅桌号"}
