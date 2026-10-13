# 底牌仍在地主手中时显示选中边框；打出后权威牌标记的归属变为-1。
$execute if score @s dd_owner matches 1..8 run data modify storage fimel_title:io text.extra append value {text:"$(selected_glyph)",color:"white",shadow_color:0}
$execute unless score @s dd_owner matches 1..8 run data modify storage fimel_title:io text.extra append value {text:"$(glyph)",color:"white",shadow_color:0}
scoreboard players add #hud_bottom_count dd_ctx 1
