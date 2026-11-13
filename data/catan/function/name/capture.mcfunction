# loot的set_name在玩家上下文提前解析姓名，Dialog不读取未解析的selector。
data modify storage catan:runtime name.value set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=ca.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["ca.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=ca.name_resolver,distance=..1,sort=nearest,limit=1] contents loot catan:player_name
data modify storage catan:runtime name.value set from entity @e[type=minecraft:item_display,tag=ca.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage catan:runtime name.value.click_event
data remove storage catan:runtime name.value.hover_event
data remove storage catan:runtime name.value.insertion
kill @e[type=minecraft:item_display,tag=ca.name_resolver,distance=..1,sort=nearest,limit=1]
