tag @s add ma.visual
tag @s add ma.racer_name
scoreboard players operation @s ct_id = #vis_table ma_ctx
$scoreboard players set @s ma_vid $(index)
data modify storage magical_athlete:visual owner_icon set value {object:"player",player:{},hat:true}
data modify storage magical_athlete:visual owner_icon.player set from storage magical_athlete:visual owner_profile
data merge entity @s {billboard:"vertical",Rotation:[0f,0f],alignment:"center",background:0,default_background:0b,shadow:0b,see_through:0b,text_opacity:-1b,line_width:16,view_range:0.5f,brightness:{block:15,sky:15}}
data modify entity @s text set from storage magical_athlete:visual owner_icon
function magical_athlete:visual/name_pose with storage magical_athlete:visual draw_pose
# scene-v2
tag @s remove ma.outdated
