tag @s add ca.deck_direct
tag @s add ca.deck_hit
scoreboard players operation @s ct_id = #table ca_ctx
data merge entity @s {width:0.5f,height:0.2f,response:1b}
