execute unless entity @s[tag=it.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s it_panel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s it_panel run scoreboard players operation @s fbt_panel = @s it_previous
execute if entity @s[tag=it.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove it.owns_hud
tag @s remove it.hud
scoreboard players reset @s it_panel
