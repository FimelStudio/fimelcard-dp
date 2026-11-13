tag @s add ca.deck_direct
scoreboard players operation @s ct_id = #table ca_ctx
$data merge entity @s {billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,text:{text:"发展卡 $(remaining)",color:"gold"},transformation:{translation:[0f,0f,0f],scale:[0.2f,0.2f,0.2f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
