tag @s add sp.visual
tag @s add sp.label
scoreboard players operation @s sp_table = #vis_table sp_ctx
scoreboard players operation @s ct_id = #vis_table sp_ctx
$scoreboard players set @s sp_vid $(id)
$scoreboard players set @s sp_vkind $(kind)
$data merge entity @s {text:$(text),billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,see_through:0b,view_range:0.7f,line_width:80}
function splendor:visual/label_pose with storage splendor:visual pose
