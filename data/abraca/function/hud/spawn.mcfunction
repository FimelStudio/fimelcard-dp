summon minecraft:text_display ~ ~1.78 ~ {data:{abraca:{new_info:1b}},text:{text:''},billboard:'vertical',alignment:'center',line_width:160,background:0,default_background:0b,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:text_display ~-1.05 ~1.10 ~-1.05 {data:{abraca:{new_pile:1b}},text:{text:'已施放咒语',color:'aqua',bold:true},billboard:'vertical',Rotation:[0f,-90f],alignment:'center',line_width:120,background:0,default_background:0b,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~-1.05 ~0.98 ~-1.05 {data:{abraca:{new_pile:1b}},width:1.15f,height:0.20f,response:1b}
tag @e[nbt={data:{abraca:{new_info:1b}}},distance=..2] add ab.info
tag @e[nbt={data:{abraca:{new_pile:1b}}},distance=..2] add ab.pile_button
tag @e[tag=ab.info,distance=..2] add ab.game_entity
tag @e[tag=ab.pile_button,distance=..2] add ab.game_entity
tag @e[tag=ab.info,distance=..2] add ct.part
tag @e[tag=ab.pile_button,distance=..2] add ct.part
scoreboard players operation @e[tag=ab.info,distance=..2] ab_id = @s ab_id
scoreboard players operation @e[tag=ab.pile_button,distance=..2] ab_id = @s ab_id
scoreboard players operation @e[tag=ab.info,distance=..2] ct_id = @s ab_id
scoreboard players operation @e[tag=ab.pile_button,distance=..2] ct_id = @s ab_id
execute as @e[type=minecraft:interaction,tag=ab.pile_button,distance=..2] run scoreboard players set @s ct_kind 41
execute as @e[tag=ab.info,distance=..2] run data remove entity @s data.abraca
execute as @e[tag=ab.pile_button,distance=..2] run data remove entity @s data.abraca
