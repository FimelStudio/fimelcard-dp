# 玩偶乐园：保留座位交互和桌号，装饰仅位于四角。
fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:barrier
execute positioned ~-1 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~-1 ~0.5 ~0 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~-1 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~0 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~0 ~0.5 ~0 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~0 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~1 ~0.5 ~-1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~1 ~0.5 ~0 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute positioned ~1 ~0.5 ~1 summon minecraft:item_display run function cardtable:skin/item {model:"toys_table",yaw:0}
execute if block ~0 ~ ~-2 minecraft:birch_stairs run setblock ~0 ~ ~-2 minecraft:air
execute positioned ~0 ~0.5 ~-2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_chair",yaw:0}
execute if block ~2 ~ ~0 minecraft:birch_stairs run setblock ~2 ~ ~0 minecraft:air
execute positioned ~2 ~0.5 ~0 summon minecraft:item_display run function cardtable:skin/item {model:"toys_chair",yaw:90}
execute if block ~0 ~ ~2 minecraft:birch_stairs run setblock ~0 ~ ~2 minecraft:air
execute positioned ~0 ~0.5 ~2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_chair",yaw:-180}
execute if block ~-2 ~ ~0 minecraft:birch_stairs run setblock ~-2 ~ ~0 minecraft:air
execute positioned ~-2 ~0.5 ~0 summon minecraft:item_display run function cardtable:skin/item {model:"toys_chair",yaw:-90}
execute positioned ~-2 ~0.5 ~-2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_corner",yaw:0}
execute positioned ~-2 ~1.5 ~-2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_prop0",yaw:45}
execute positioned ~2 ~0.5 ~-2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_corner",yaw:0}
execute positioned ~2 ~1.5 ~-2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_prop1",yaw:-45}
execute positioned ~2 ~0.5 ~2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_corner",yaw:0}
execute positioned ~2 ~1.5 ~2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_prop0",yaw:45}
execute positioned ~-2 ~0.5 ~2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_corner",yaw:0}
execute positioned ~-2 ~1.5 ~2 summon minecraft:item_display run function cardtable:skin/item {model:"toys_prop1",yaw:-45}
