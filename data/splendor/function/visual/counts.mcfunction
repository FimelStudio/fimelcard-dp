tag @s add sp.visual
scoreboard players operation @s sp_table = #vis_table sp_ctx
scoreboard players operation @s ct_id = #vis_table sp_ctx
$data merge entity @s {text:[{"text":"","font":"card:splendor/small"},{"text":"×$(b0)  ","color":"white"},{"text":"","font":"card:splendor/small"},{"text":"×$(b1)  ","color":"white"},{"text":"","font":"card:splendor/small"},{"text":"×$(b2)  ","color":"white"},{"text":"","font":"card:splendor/small"},{"text":"×$(b3)  ","color":"white"},{"text":"","font":"card:splendor/small"},{"text":"×$(b4)  ","color":"white"},{"text":"","font":"card:splendor/small"},{"text":"×$(b5)","color":"white"}],billboard:"center",background:0,shadow:1b,view_range:0.5f,line_width:500,transformation:{scale:[0.18f,0.18f,0.18f]}}
