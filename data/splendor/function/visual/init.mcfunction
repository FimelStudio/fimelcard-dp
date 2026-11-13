tag @s add sp.visual
scoreboard players operation @s sp_table = #vis_table sp_ctx
scoreboard players operation @s ct_id = #vis_table sp_ctx
$scoreboard players set @s sp_vid $(id)
$scoreboard players set @s sp_vkind $(kind)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:splendor/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
function splendor:visual/pose with storage splendor:visual pose
execute if score @s sp_vkind matches 2..5 run function splendor:direct/spawn with storage splendor:visual pose
