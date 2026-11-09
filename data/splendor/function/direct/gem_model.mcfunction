execute if score @s sp_vid matches 0 run data merge entity @s {item:{id:"minecraft:diamond",count:1,components:{"minecraft:item_model":"minecraft:diamond"}}}
execute if score @s sp_vid matches 1 run data merge entity @s {item:{id:"minecraft:lapis_lazuli",count:1,components:{"minecraft:item_model":"minecraft:lapis_lazuli"}}}
execute if score @s sp_vid matches 2 run data merge entity @s {item:{id:"minecraft:emerald",count:1,components:{"minecraft:item_model":"minecraft:emerald"}}}
execute if score @s sp_vid matches 3 run data merge entity @s {item:{id:"minecraft:redstone",count:1,components:{"minecraft:item_model":"minecraft:redstone"}}}
execute if score @s sp_vid matches 4 run data merge entity @s {item:{id:"minecraft:coal",count:1,components:{"minecraft:item_model":"minecraft:coal"}}}
execute if score @s sp_vid matches 5 run data merge entity @s {item:{id:"minecraft:gold_ingot",count:1,components:{"minecraft:item_model":"minecraft:gold_ingot"}}}
function splendor:direct/gem_pose with storage splendor:visual pose
