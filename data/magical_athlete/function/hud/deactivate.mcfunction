execute unless entity @s[tag=ma.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s ma_hpanel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s ma_hpanel run function magical_athlete:hud/restore
execute if entity @s[tag=ma.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove ma.owns_hud
tag @s remove ma.hud
