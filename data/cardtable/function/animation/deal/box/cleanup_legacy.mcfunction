# 仅清理本桌附近、没有归属编号或牌桌标签、参数匹配旧版初始牌盒的实体。
# 正在播放的正常牌盒有 ct.deal_box/ct.part 和 ct_id，不会被误删。
execute as @e[type=minecraft:item_display,tag=!ct.deal_box,tag=!ct.part,distance=..3,nbt={item:{id:"minecraft:paper",components:{"minecraft:item_model":"card:cardbox"}},item_display:"ground",transformation:{scale:[0.1f,0.1f,0.1f]},brightness:{block:15,sky:15},interpolation_duration:10,view_range:24f}] unless score @s ct_id = @s ct_id run kill @s
