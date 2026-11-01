# 解析实际玩家名字为字面组件，防止 Dialog 将 selector 当作文字显示。
data modify storage love_letter:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["ll.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1] contents loot love_letter:player_name
data modify storage love_letter:name resolved set from entity @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage love_letter:name resolved.click_event
data remove storage love_letter:name resolved.hover_event
data remove storage love_letter:name resolved.insertion
kill @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1]
