# loot的set_name在玩家上下文提前解析姓名，Dialog不读取未解析的selector。
data modify storage magical_athlete:runtime name.value set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=ma.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["ma.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=ma.name_resolver,distance=..1,sort=nearest,limit=1] contents loot magical_athlete:player_name
data modify storage magical_athlete:runtime name.value set from entity @e[type=minecraft:item_display,tag=ma.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage magical_athlete:runtime name.value.click_event
data remove storage magical_athlete:runtime name.value.hover_event
data remove storage magical_athlete:runtime name.value.insertion
kill @e[type=minecraft:item_display,tag=ma.name_resolver,distance=..1,sort=nearest,limit=1]
