execute unless entity @s[tag=ca.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s ca_hpanel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s ca_hpanel run function catan:hud/restore
execute if entity @s[tag=ca.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove ca.owns_hud
tag @s remove ca.hud
