# 当前执行者是花火控制器；桌角文字平放并朝上，点击区只覆盖文字附近
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @e[tag=hb.discard_button] if score @s hb_id = #ctx_id hb_ctx run kill @s

summon minecraft:text_display ~-1.05 ~1.1 ~-1.05 {data:{hanabi:{new_discard_button:1b}},text:{text:"弃牌堆",color:"aqua",bold:true},billboard:"vertical",Rotation:[0f,-90f],alignment:"center",line_width:100,background:0,default_background:0b,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~-1.05 ~0.98 ~-1.05 {data:{hanabi:{new_discard_button:1b}},width:0.82f,height:0.20f,response:1b}

tag @e[nbt={data:{hanabi:{new_discard_button:1b}}},distance=..2] add hb.new_discard_button
tag @e[tag=hb.new_discard_button,distance=..2] add hb.discard_button
tag @e[tag=hb.new_discard_button,distance=..2] add hb.game_entity
tag @e[tag=hb.new_discard_button,distance=..2] add ct.part
scoreboard players operation @e[tag=hb.new_discard_button,distance=..2] hb_id = @s hb_id
scoreboard players operation @e[tag=hb.new_discard_button,distance=..2] ct_id = @s hb_id
execute as @e[type=minecraft:interaction,tag=hb.new_discard_button,distance=..2] run scoreboard players set @s ct_kind 32
execute as @e[tag=hb.new_discard_button,distance=..2] run data remove entity @s data.hanabi
tag @e[tag=hb.new_discard_button,distance=..2] remove hb.new_discard_button
