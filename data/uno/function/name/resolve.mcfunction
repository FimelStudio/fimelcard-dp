# 当前执行者是该行玩家；不向玩家背包写物品，不保留临时展示实体。
data modify storage uno:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["un.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1] contents loot uno:player_name
data modify storage uno:name resolved set from entity @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
# 移除名字自带的私聊/悬浮事件，保持对话框显示与按钮行为独立。
data remove storage uno:name resolved.click_event
data remove storage uno:name resolved.hover_event
data remove storage uno:name resolved.insertion
kill @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1]
