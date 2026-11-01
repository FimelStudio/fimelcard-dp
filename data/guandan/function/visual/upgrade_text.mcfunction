tag @s add gd.visual
tag @s add gd.fx
tag @s add gd.upgrade
scoreboard players operation @s ct_id = #vis_table gd_ctx
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 30
$data merge entity @s {text:{text:"升 $(steps) 级",color:"gold",bold:1b},billboard:"center",background:0,shadow:1b,view_range:0.5f,interpolation_duration:30,start_interpolation:0,transformation:{translation:[0f,0.32f,0f],scale:[0.25f,0.25f,0.25f]}}
