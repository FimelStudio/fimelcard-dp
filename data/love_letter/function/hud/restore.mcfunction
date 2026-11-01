scoreboard players set @s fbt_panel 0
execute if score @s ll_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s ll_prev_panel
title @s actionbar {text:""}
