execute unless score @s wq_prev_panel matches 0.. run return 0
scoreboard players set @s title.panel_id 0
execute if score @s wq_prev_panel matches 1.. run scoreboard players operation @s title.panel_id = @s wq_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s wq_prev_panel
execute if entity @s[tag=wq.owns_actionbar_block] run tag @s remove cgt_anim_text.replace.actionbar
tag @s remove wq.owns_actionbar_block
