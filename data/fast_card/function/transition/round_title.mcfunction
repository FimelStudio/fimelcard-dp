# “第　　　局”和局数使用两个同步动画实例叠放，数字正好位于中文留出的中央空位
# 这样既能动态读取任意局数，也能绕开26.2对“中文+动态组件”的错误转码
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.05]
summon minecraft:text_display ~ ~ ~ {data:{fast_card:{transition_template:1b}},text:{text:'第　　　局',color:'gold',bold:true},see_through:0b}
data modify storage minecraft:cgt_anim_text positional.animation.data set value {analyse:0b,sound:0,speed:300,style:30,scale:1.35f,entity_properties:{billboard:"vertical",alignment:"center",line_width:160,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}}
data modify storage minecraft:cgt_anim_text positional.animation.data.text set value []
data modify storage minecraft:cgt_anim_text positional.animation.data.text append from entity @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1]
execute positioned ~ ~1.70 ~ rotated 0 0 run function fast_card:transition/library_animation_load

# 数字实体只含ASCII，不会发生中文转码
summon minecraft:text_display ~ ~ ~ {data:{fast_card:{transition_template:1b}},text:{score:{name:'@e[type=minecraft:marker,tag=fc.controller,sort=nearest,limit=1]',objective:'fc_round'},color:'gold',bold:true},see_through:0b}
data modify storage minecraft:cgt_anim_text positional.animation.data set value {analyse:0b,sound:0,speed:300,style:30,scale:1.35f,entity_properties:{billboard:"vertical",alignment:"center",line_width:160,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}}
data modify storage minecraft:cgt_anim_text positional.animation.data.text set value []
data modify storage minecraft:cgt_anim_text positional.animation.data.text append from entity @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1]
execute positioned ~ ~1.70 ~ rotated 0 0 run function fast_card:transition/library_animation_load

# 两个实例都绑定到本桌，清理和多桌隔离按动画库实例编号执行
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute positioned ~ ~1.70 ~ run scoreboard players operation @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=!fc.transition,distance=..0.05] fc_id = #ctx_id fc_ctx
execute positioned ~ ~1.70 ~ run tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=!fc.transition,distance=..0.05] add fc.transition
execute positioned ~ ~1.70 ~ run tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=fc.transition,distance=..0.05] add fc.transition.root

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.25
