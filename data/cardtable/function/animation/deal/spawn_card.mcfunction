# 在牌盒上方生成一张待配置的真实纸牌，并可靠添加公共临时标签
# 26.2不依赖召唤NBT中的旧Tags字段，因此先用data定位再添加命令标签
kill @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2]
summon minecraft:item ~ ~1.18 ~ {data:{cardtable:{new_dealt_card:1b}},Item:{id:"minecraft:paper",count:1},PickupDelay:2s,Age:0s,Motion:[0.0d,0.10d,0.0d]}
tag @e[type=minecraft:item,nbt={data:{cardtable:{new_dealt_card:1b}}},distance=..2,sort=nearest,limit=1] add ct.new_dealt_card
execute as @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] run data remove entity @s data.cardtable
