tag @s add ma.direct
$scoreboard players set @s ct_id $(table)
$data merge entity @s {billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,text:{text:"$(name)",color:"aqua"},transformation:{translation:[0f,0f,0f],scale:[0.18f,0.18f,0.18f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
# scene-v2
tag @s add ma.pool_title
$scoreboard players set @s ma_did $(id)
