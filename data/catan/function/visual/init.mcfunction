tag @s add ca.visual
scoreboard players operation @s ct_id = #vis_table ca_ctx
$scoreboard players set @s ca_vid $(id)
$scoreboard players set @s ca_vkind $(kind)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:catan/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,shadow_strength:0f,view_range:0.5f}
function catan:visual/pose with storage catan:visual pose
