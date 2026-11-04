execute unless data storage fimel_title:io panels run function fimel_title:code/load
scoreboard players set @s sp_hprev 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s sp_hprev = @s fbt_panel
scoreboard players reset @s sp_hpanel
function fimel_title:new_panel {id:"@s sp_hpanel"}
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add sp.owns_hud
tag @s add fimel.anim_text.replace.actionbar
tag @s add sp.hud
