# 26.2不再保留召唤NBT中的旧Tags字段，因此先用data定位，再添加命令标签
# 每个标记代表一张唯一牌；随机选中后立即删除，因此不会重复发牌
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 1
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 2
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 3
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 4
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 5
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 6
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 7
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 8
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 9
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 10
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 11
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 12
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 13
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 14
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 15
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 16
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
summon minecraft:marker ~ ~ ~ {data:{fast_card:{deck_new:1b}}}
tag @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] add fc.deck
scoreboard players set @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] fc_card 17
execute as @e[type=minecraft:marker,nbt={data:{fast_card:{deck_new:1b}}},distance=..0.01,limit=1] run data remove entity @s data.fast_card
