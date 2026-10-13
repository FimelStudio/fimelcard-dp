execute unless score @s wq_prev_panel matches 0.. run return 0
scoreboard players set @s fbt_panel 0
execute if score @s wq_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s wq_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s wq_prev_panel
execute if entity @s[tag=wq.owns_actionbar_block] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove wq.owns_actionbar_block
