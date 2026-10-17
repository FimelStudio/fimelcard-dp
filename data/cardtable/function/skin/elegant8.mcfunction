# 家具只使用本桌 ct.skin 展示实体，保留全部座位交互。
fill ~-2 ~ ~-2 ~1 ~ ~1 minecraft:barrier
execute positioned ~-1.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-1.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-1.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-1.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-0.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-0.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-0.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~-0.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~0.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~0.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~0.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~0.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~1.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~1.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~1.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute positioned ~1.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"table",yaw:0}
execute if block ~-1 ~ ~-2.5 minecraft:birch_stairs run setblock ~-1 ~ ~-2.5 minecraft:air
execute positioned ~-1 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:0}
execute if block ~1 ~ ~-2.5 minecraft:birch_stairs run setblock ~1 ~ ~-2.5 minecraft:air
execute positioned ~1 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:0}
execute if block ~2.5 ~ ~-1 minecraft:birch_stairs run setblock ~2.5 ~ ~-1 minecraft:air
execute positioned ~2.5 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:90}
execute if block ~2.5 ~ ~1 minecraft:birch_stairs run setblock ~2.5 ~ ~1 minecraft:air
execute positioned ~2.5 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:90}
execute if block ~1 ~ ~2.5 minecraft:birch_stairs run setblock ~1 ~ ~2.5 minecraft:air
execute positioned ~1 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:-180}
execute if block ~-1 ~ ~2.5 minecraft:birch_stairs run setblock ~-1 ~ ~2.5 minecraft:air
execute positioned ~-1 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:-180}
execute if block ~-2.5 ~ ~1 minecraft:birch_stairs run setblock ~-2.5 ~ ~1 minecraft:air
execute positioned ~-2.5 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:-90}
execute if block ~-2.5 ~ ~-1 minecraft:birch_stairs run setblock ~-2.5 ~ ~-1 minecraft:air
execute positioned ~-2.5 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"sofa",yaw:-90}
execute positioned ~-2.5 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"corner",yaw:0}
execute positioned ~-2.5 ~1.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sunflower",yaw:45}
execute positioned ~2.5 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"corner",yaw:0}
execute positioned ~2.5 ~1.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"pink_flower",yaw:-45}
execute positioned ~2.5 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"corner",yaw:0}
execute positioned ~2.5 ~1.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"sunflower",yaw:-45}
execute positioned ~-2.5 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"corner",yaw:0}
execute positioned ~-2.5 ~1.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"pink_flower",yaw:45}
