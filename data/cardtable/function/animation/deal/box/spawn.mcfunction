# 执行者必须是牌桌控制器，执行位置必须是牌桌中心
# 牌盒以0.1倍大小生成，调用方应至少等待一个完整游戏刻后再调用grow
summon minecraft:item_display ~ ~1.4 ~ {data:{cardtable:{deal_box_new:1b}},item:{id:"paper",components:{item_model:"card:cardbox"}},item_display:"ground",transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.1f,0.1f,0.1f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},interpolation_duration:10,view_range:24f,brightness:{block:15,sky:15}}
tag @e[type=minecraft:item_display,nbt={data:{cardtable:{deal_box_new:1b}}},distance=..2.1,sort=nearest,limit=1] add ct.new_deal_box
tag @e[type=minecraft:item_display,tag=ct.new_deal_box,distance=..2.1,sort=nearest,limit=1] add ct.deal_box
tag @e[type=minecraft:item_display,tag=ct.new_deal_box,distance=..2.1,sort=nearest,limit=1] add ct.part
scoreboard players operation @e[type=minecraft:item_display,tag=ct.new_deal_box,distance=..2.1,sort=nearest,limit=1] ct_id = @s ct_id
execute as @e[type=minecraft:item_display,tag=ct.new_deal_box,distance=..2.1,sort=nearest,limit=1] run data remove entity @s data.cardtable
tag @e[type=minecraft:item_display,tag=ct.new_deal_box,distance=..2.1,sort=nearest,limit=1] remove ct.new_deal_box
