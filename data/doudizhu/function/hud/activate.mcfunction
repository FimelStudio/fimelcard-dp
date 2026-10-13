execute unless data storage fimel_title:io panels run function fimel_title:code/load
scoreboard players set @s dd_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s dd_prev_panel = @s fbt_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add dd.owns_actionbar
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s dd_panel"}
scoreboard players operation @s fbt_panel = @s dd_panel
