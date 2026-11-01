data modify storage ito:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=it.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["it.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=it.name_resolver,distance=..1,sort=nearest,limit=1] contents loot ito:player_name
data modify storage ito:name resolved set from entity @e[type=minecraft:item_display,tag=it.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage ito:name resolved.click_event
data remove storage ito:name resolved.hover_event
data remove storage ito:name resolved.insertion
kill @e[type=minecraft:item_display,tag=it.name_resolver,distance=..1,sort=nearest,limit=1]
