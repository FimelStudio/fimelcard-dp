tag @s add ca.visual
scoreboard players operation @s ct_id = #vis_table ca_ctx
$scoreboard players set @s ca_vid $(id)
$scoreboard players set @s ca_vkind $(kind)
$data merge entity @s {billboard:"vertical",Rotation:[0f,0f],item_display:"none",item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:catan/$(model)"}},brightness:{block:15,sky:15},shadow_radius:0f,shadow_strength:0f,view_range:0.75f}
function catan:visual/label_anchor with storage catan:visual pose
