tag @s add gm.visual
tag @s add gm.man
scoreboard players operation @s ct_id = #vis_table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$scoreboard players set @s gm_piece $(side)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:gomoku/stone/$(palette)_$(color)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
function gomoku:visual/stone_pose with storage gomoku:visual
