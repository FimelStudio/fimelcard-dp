tag @s add ca.surface
scoreboard players operation @s ct_id = #input_table ca_ctx
$data merge entity @s {width:$(width),height:0.035f,response:1b}
