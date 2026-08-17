# 标准模式显示五堆；彩色风暴开启时改用六个等距位置并加入彩色牌堆
execute if score @s hb_storm matches 0 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:1}},item_display:"on_shelf",transformation:{translation:[-1.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 0 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:2}},item_display:"on_shelf",transformation:{translation:[-0.5f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 0 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:3}},item_display:"on_shelf",transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 0 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:4}},item_display:"on_shelf",transformation:{translation:[0.5f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 0 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:5}},item_display:"on_shelf",transformation:{translation:[1.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:1}},item_display:"on_shelf",transformation:{translation:[-1.25f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:2}},item_display:"on_shelf",transformation:{translation:[-0.75f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:3}},item_display:"on_shelf",transformation:{translation:[-0.25f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:4}},item_display:"on_shelf",transformation:{translation:[0.25f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:5}},item_display:"on_shelf",transformation:{translation:[0.75f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
execute if score @s hb_storm matches 1 run summon minecraft:item_display ~ ~1.1 ~ {data:{hanabi:{new_stack:1b,color:6}},item_display:"on_shelf",transformation:{translation:[1.25f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.2f,1.2f,1.2f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:text_display ~ ~1.75 ~ {data:{hanabi:{new_info:1b}},text:{text:""},billboard:"vertical",alignment:"center",line_width:120,background:0,default_background:0b,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}

tag @e[nbt={data:{hanabi:{new_stack:1b}}},distance=..2] add hb.stack
tag @e[nbt={data:{hanabi:{new_info:1b}}},distance=..2] add hb.info
tag @e[tag=hb.stack,distance=..2] add hb.game_entity
tag @e[tag=hb.info,distance=..2] add hb.game_entity
tag @e[tag=hb.stack,distance=..2] add ct.part
tag @e[tag=hb.info,distance=..2] add ct.part
scoreboard players operation @e[tag=hb.stack,distance=..2] hb_id = @s hb_id
scoreboard players operation @e[tag=hb.info,distance=..2] hb_id = @s hb_id
scoreboard players operation @e[tag=hb.stack,distance=..2] ct_id = @s hb_id
scoreboard players operation @e[tag=hb.info,distance=..2] ct_id = @s hb_id
execute as @e[tag=hb.stack,distance=..2] store result score @s hb_color run data get entity @s data.hanabi.color
execute as @e[tag=hb.stack,distance=..2] run data remove entity @s data.hanabi
execute as @e[tag=hb.info,distance=..2] run data remove entity @s data.hanabi
