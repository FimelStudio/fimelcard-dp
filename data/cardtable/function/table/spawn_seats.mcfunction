# 仅生成牌桌实体逻辑，不放置或修改任何方块
# 四个座位锚点对应中心北、东、南、西各2格，适用于默认桌椅和相同布局的自定义桌椅

# 交互高度保持为原始值的3/5（0.372），载具基准点设为Y+0.32以改善桌面视野
summon minecraft:interaction ~ ~0.32 ~-2 {data:{cardtable:{new_part:1b,seat:1}},width:0.96f,height:0.372f,response:1b}
summon minecraft:interaction ~2 ~0.32 ~ {data:{cardtable:{new_part:1b,seat:2}},width:0.96f,height:0.372f,response:1b}
summon minecraft:interaction ~ ~0.32 ~2 {data:{cardtable:{new_part:1b,seat:3}},width:0.96f,height:0.372f,response:1b}
summon minecraft:interaction ~-2 ~0.32 ~ {data:{cardtable:{new_part:1b,seat:4}},width:0.96f,height:0.372f,response:1b}

# 26.2的summon不会保留命令标签，先用data识别，再转为命令标签
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{new_part:1b}}},distance=..3] run tag @s add ct.new_part
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{new_part:1b}}},distance=..3] run tag @s add ct.part
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{seat:1}}},distance=..3] run tag @s add ct.new_seat1
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{seat:2}}},distance=..3] run tag @s add ct.new_seat2
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{seat:3}}},distance=..3] run tag @s add ct.new_seat3
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{seat:4}}},distance=..3] run tag @s add ct.new_seat4
tag @e[type=minecraft:interaction,tag=ct.new_part,distance=..3] add ct.seat
execute as @e[type=minecraft:interaction,tag=ct.new_part,distance=..3] run data remove entity @s data.cardtable
