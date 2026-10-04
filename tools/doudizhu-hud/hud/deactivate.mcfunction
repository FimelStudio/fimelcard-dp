execute if score @s dd_panel matches 1.. run scoreboard players set @s title.panel_id 0
execute if score @s dd_prev_panel matches 1.. run scoreboard players operation @s title.panel_id = @s dd_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s dd_prev_panel
scoreboard players reset @s dd_panel
execute if entity @s[tag=dd.owns_actionbar] run tag @s remove cgt_anim_text.replace.actionbar
tag @s remove dd.owns_actionbar
