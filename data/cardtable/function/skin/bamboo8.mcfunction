# 竹影茶室：保留座位交互和桌号，装饰仅位于四角。
fill ~-2 ~ ~-2 ~1 ~ ~1 minecraft:barrier
execute positioned ~-1.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-1.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-1.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-1.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-0.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-0.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-0.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~-0.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~0.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~0.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~0.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~0.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~1.5 ~0.5 ~-1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~1.5 ~0.5 ~-0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~1.5 ~0.5 ~0.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute positioned ~1.5 ~0.5 ~1.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_table",yaw:0}
execute if block ~-1 ~ ~-2.5 minecraft:birch_stairs run setblock ~-1 ~ ~-2.5 minecraft:air
execute positioned ~-1 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:0}
execute if block ~1 ~ ~-2.5 minecraft:birch_stairs run setblock ~1 ~ ~-2.5 minecraft:air
execute positioned ~1 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:0}
execute if block ~2.5 ~ ~-1 minecraft:birch_stairs run setblock ~2.5 ~ ~-1 minecraft:air
execute positioned ~2.5 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:90}
execute if block ~2.5 ~ ~1 minecraft:birch_stairs run setblock ~2.5 ~ ~1 minecraft:air
execute positioned ~2.5 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:90}
execute if block ~1 ~ ~2.5 minecraft:birch_stairs run setblock ~1 ~ ~2.5 minecraft:air
execute positioned ~1 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:-180}
execute if block ~-1 ~ ~2.5 minecraft:birch_stairs run setblock ~-1 ~ ~2.5 minecraft:air
execute positioned ~-1 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:-180}
execute if block ~-2.5 ~ ~1 minecraft:birch_stairs run setblock ~-2.5 ~ ~1 minecraft:air
execute positioned ~-2.5 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:-90}
execute if block ~-2.5 ~ ~-1 minecraft:birch_stairs run setblock ~-2.5 ~ ~-1 minecraft:air
execute positioned ~-2.5 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_chair",yaw:-90}
execute positioned ~-2.5 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_corner",yaw:0}
execute positioned ~-2.5 ~1.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_prop0",yaw:45}
execute positioned ~2.5 ~0.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_corner",yaw:0}
execute positioned ~2.5 ~1.5 ~-2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_prop1",yaw:-45}
execute positioned ~2.5 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_corner",yaw:0}
execute positioned ~2.5 ~1.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_prop0",yaw:45}
execute positioned ~-2.5 ~0.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_corner",yaw:0}
execute positioned ~-2.5 ~1.5 ~2.5 summon minecraft:item_display run function cardtable:skin/item {model:"bamboo_prop1",yaw:-45}
