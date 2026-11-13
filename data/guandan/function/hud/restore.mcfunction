scoreboard players set @s fbt_panel 0
execute if score @s gd_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s gd_prev_panel
execute if entity @s[tag=gd.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
title @s actionbar {text:""}
