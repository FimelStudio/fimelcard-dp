tag @s add av.game_entity
scoreboard players operation @s av_id = #table av_ctx
data merge entity @s {billboard:"center",background:0,shadow:1b,see_through:0b,line_width:360,view_range:24f,transformation:{translation:[0f,0f,0f],scale:[0.65f,0.65f,0.65f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
tp @s ~ ~2.2 ~
tag @s add av.hud_animated
data modify storage fimel_anim_text:runtime positional.typewriter.data set value {text:[],speed:2000,style:0,analyse:1b,width:2048,sound:0}
data modify storage fimel_anim_text:runtime positional.typewriter.data.text set from storage avalon:hud text
function fimel_anim_text:positional/typewriter/start/set
function fimel_anim_text:positional/typewriter/start/summon
