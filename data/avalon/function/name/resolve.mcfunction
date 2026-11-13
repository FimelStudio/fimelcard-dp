# 当前执行者必须是需要解析名字的在线玩家。
# Dialog不会解析选择器组件，因此借助set_name在战利品上下文中先把@s固化成静态文本。
data modify storage avalon:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=av.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["av.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=av.name_resolver,distance=..1,sort=nearest,limit=1] contents loot avalon:player_name
data modify storage avalon:name resolved set from entity @e[type=minecraft:item_display,tag=av.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
# 选择器解析出的玩家名会附带私聊点击事件；Dialog按钮必须只继承外层trigger事件。
data remove storage avalon:name resolved.click_event
data remove storage avalon:name resolved.hover_event
data remove storage avalon:name resolved.insertion
kill @e[type=minecraft:item_display,tag=av.name_resolver,distance=..1,sort=nearest,limit=1]
