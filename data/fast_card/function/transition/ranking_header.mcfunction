# 中央结算标题使用中心淡入淡出样式
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.05]
summon minecraft:text_display ~ ~ ~ {data:{fast_card:{transition_template:1b}},text:[{text:'积',color:'yellow',bold:true},{text:'分',color:'yellow',bold:true},{text:'变',color:'yellow',bold:true},{text:'化',color:'yellow',bold:true}],see_through:0b}
data modify storage fimel_anim_text:runtime positional.animation.data set value {analyse:0b,sound:0,speed:300,style:30,scale:1.05f,entity_properties:{billboard:"vertical",alignment:"center",line_width:180,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}}
data modify storage fimel_anim_text:runtime positional.animation.data.text set value []
data modify storage fimel_anim_text:runtime positional.animation.data.text append from entity @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1]
execute positioned ~ ~1.95 ~ rotated 0 0 run function fast_card:transition/library_animation_load

scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute positioned ~ ~1.95 ~ run scoreboard players operation @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.center,tag=!fc.transition,distance=..0.05,sort=nearest,limit=1] fc_id = #ctx_id fc_ctx
execute positioned ~ ~1.95 ~ run tag @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.center,tag=!fc.transition,distance=..0.05,sort=nearest,limit=1] add fc.transition
execute positioned ~ ~1.95 ~ run tag @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.center,tag=fc.transition,distance=..0.05,sort=nearest,limit=1] add fc.transition.root

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.55 1.1
