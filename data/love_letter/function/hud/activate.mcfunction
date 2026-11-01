execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=ll.hud_active] run return 0
scoreboard players set @s ll_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s ll_prev_panel = @s fbt_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add ll.owns_actionbar
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s ll_panel"}
tag @s add ll.hud_active
