execute unless data storage fimel_title:io panels run function fimel_title:code/load
scoreboard players set @s it_previous 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s it_previous = @s fbt_panel
scoreboard players reset @s it_panel
function fimel_title:new_panel {id:"@s it_panel"}
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add it.owns_hud
tag @s add fimel.anim_text.replace.actionbar
tag @s add it.hud
