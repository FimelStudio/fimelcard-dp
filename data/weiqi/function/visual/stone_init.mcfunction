tag @s add go.visual
tag @s add go.man
scoreboard players operation @s ct_id = #vis_table go_ctx
$scoreboard players set @s go_sq $(sq)
$scoreboard players set @s go_piece $(side)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:weiqi/stone/$(palette)_$(color)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
function weiqi:visual/stone_pose with storage weiqi:visual
