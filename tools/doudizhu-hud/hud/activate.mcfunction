execute unless data storage title:io panels run function title:code/load
scoreboard players set @s dd_prev_panel 0
execute if score @s title.panel_id matches 1.. run scoreboard players operation @s dd_prev_panel = @s title.panel_id
execute unless entity @s[tag=cgt_anim_text.replace.actionbar] run tag @s add dd.owns_actionbar
tag @s add cgt_anim_text.replace.actionbar
function title:new_panel {id:"@s dd_panel"}
scoreboard players operation @s title.panel_id = @s dd_panel
