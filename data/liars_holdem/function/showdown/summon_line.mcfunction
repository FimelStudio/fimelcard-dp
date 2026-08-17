# 五张80像素牌图按0.22缩放，既能辨认又不会完全遮住牌桌
$summon minecraft:text_display ~ ~$(y) ~ {data:{liars_holdem:{new_showdown_display:1b}},text:$(line),billboard:"vertical",alignment:"center",line_width:600,background:1073741824,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.22f,0.22f,0.22f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
tag @e[type=minecraft:text_display,nbt={data:{liars_holdem:{new_showdown_display:1b}}},distance=..4,sort=nearest,limit=1] add lh.new_showdown_display
tag @e[type=minecraft:text_display,tag=lh.new_showdown_display,limit=1] add lh.showdown_display
tag @e[type=minecraft:text_display,tag=lh.new_showdown_display,limit=1] add lh.game_entity
scoreboard players operation @e[type=minecraft:text_display,tag=lh.new_showdown_display,limit=1] lh_id = @s lh_id
execute as @e[type=minecraft:text_display,tag=lh.new_showdown_display,limit=1] run data remove entity @s data.liars_holdem
tag @e[type=minecraft:text_display,tag=lh.new_showdown_display] remove lh.new_showdown_display
