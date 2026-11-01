tag @s add gd.visual
tag @s add gd.label
scoreboard players operation @s ct_id = #vis_table gd_ctx
$scoreboard players set @s gd_v_seat $(seat)
$data merge entity @s {text:{text:"",extra:[$(name),{text:" · 队$(team)$(count_text)$(turn_text)",color:"gray"}]},billboard:"fixed",Rotation:[$(yaw)f,-90f],background:0,shadow:0b,view_range:0.5f,line_width:300,transformation:{scale:[0.13f,0.13f,0.13f]}}
