tag @s add ma.visual
tag @s add ma.racer
scoreboard players operation @s ct_id = #vis_table ma_ctx
$scoreboard players set @s ma_vid $(index)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/racer/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0.04f,view_range:0.5f}
function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose
# scene-v2
tag @s remove ma.outdated
