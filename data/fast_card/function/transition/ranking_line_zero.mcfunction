kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.05]
$summon minecraft:text_display ~ ~ ~ {data:{fast_card:{transition_template:1b}},text:[{text:'$(rank). ',color:'yellow',bold:true},{text:'$(seat)号座位  ',color:'white'},{text:'$(score)分  ',color:'gold'},{text:'(—)  ',color:'gray'}],see_through:0b}
data modify storage minecraft:cgt_anim_text positional.typewriter.data set value {analyse:0b,sound:0,speed:300,style:0,width:48,entity_properties:{billboard:"vertical",alignment:"center",line_width:320,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}}
data modify storage minecraft:cgt_anim_text positional.typewriter.data.text set value []
data modify storage minecraft:cgt_anim_text positional.typewriter.data.text append from entity @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1]
summon minecraft:text_display ~ ~ ~ {data:{fast_card:{transition_template:1b}},text:{selector:'@a[tag=fc.rank_pick,limit=1]',color:'white'},see_through:0b}
data modify storage minecraft:cgt_anim_text positional.typewriter.data.text append from entity @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{fast_card:{transition_template:1b}}},distance=..0.01,limit=1]
function fast_card:transition/library_typewriter_load
