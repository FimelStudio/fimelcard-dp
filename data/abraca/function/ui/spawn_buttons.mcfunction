scoreboard players operation #ctx ab_ctx = @s ab_id
function abraca:ui/clear_buttons
summon minecraft:text_display ~-1.20 ~1.12 ~-0.35 {data:{abraca:{button:1}},text:{text:'[1]',color:'red',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~-1.20 ~1.02 ~-0.35 {data:{abraca:{button:1}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~-0.85 ~1.12 ~-0.35 {data:{abraca:{button:2}},text:{text:'[2]',color:'dark_gray',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~-0.85 ~1.02 ~-0.35 {data:{abraca:{button:2}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~-0.50 ~1.12 ~-0.35 {data:{abraca:{button:3}},text:{text:'[3]',color:'light_purple',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~-0.50 ~1.02 ~-0.35 {data:{abraca:{button:3}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~-0.15 ~1.12 ~-0.35 {data:{abraca:{button:4}},text:{text:'[4]',color:'gold',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~-0.15 ~1.02 ~-0.35 {data:{abraca:{button:4}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~0.20 ~1.12 ~-0.35 {data:{abraca:{button:5}},text:{text:'[5]',color:'aqua',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~0.20 ~1.02 ~-0.35 {data:{abraca:{button:5}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~0.55 ~1.12 ~-0.35 {data:{abraca:{button:6}},text:{text:'[6]',color:'white',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~0.55 ~1.02 ~-0.35 {data:{abraca:{button:6}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~0.90 ~1.12 ~-0.35 {data:{abraca:{button:7}},text:{text:'[7]',color:'red',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~0.90 ~1.02 ~-0.35 {data:{abraca:{button:7}},width:0.35f,height:0.22f,response:1b}
summon minecraft:text_display ~1.25 ~1.12 ~-0.35 {data:{abraca:{button:8}},text:{text:'[8]',color:'green',bold:true},billboard:'vertical',alignment:'center',background:0,shadow:1b,see_through:0b}
summon minecraft:interaction ~1.25 ~1.02 ~-0.35 {data:{abraca:{button:8}},width:0.35f,height:0.22f,response:1b}
tag @e[nbt={data:{abraca:{button:1}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:2}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:3}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:4}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:5}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:6}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:7}}},distance=..2] add ab.action_button
tag @e[nbt={data:{abraca:{button:8}}},distance=..2] add ab.action_button
tag @e[tag=ab.action_button,distance=..2] add ab.game_entity
tag @e[tag=ab.action_button,distance=..2] add ct.part
scoreboard players operation @e[tag=ab.action_button,distance=..2] ab_id = @s ab_id
scoreboard players operation @e[tag=ab.action_button,distance=..2] ct_id = @s ab_id
execute as @e[tag=ab.action_button,distance=..2] store result score @s ab_spell run data get entity @s data.abraca.button
execute as @e[type=minecraft:interaction,tag=ab.action_button,distance=..2] run scoreboard players operation @s ct_kind = @s ab_spell
execute as @e[type=minecraft:interaction,tag=ab.action_button,distance=..2] run scoreboard players add @s ct_kind 50
execute as @e[tag=ab.action_button,distance=..2] run data remove entity @s data.abraca
