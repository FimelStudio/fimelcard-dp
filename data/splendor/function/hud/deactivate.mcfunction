execute unless entity @s[tag=sp.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s sp_hpanel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s sp_hpanel run scoreboard players operation @s fbt_panel = @s sp_hprev
execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove sp.owns_hud
tag @s remove sp.hud
scoreboard players reset @s sp_hpanel
