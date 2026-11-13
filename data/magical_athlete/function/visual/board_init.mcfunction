tag @s add ma.visual
tag @s add ma.board
scoreboard players operation @s ct_id = #vis_table ma_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/board/$(track)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
data modify storage magical_athlete:visual board set from storage magical_athlete:visual layout
function magical_athlete:visual/board_pose with storage magical_athlete:visual board
