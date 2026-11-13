scoreboard players set @s fbt_panel 0
execute if score @s sp_hprev matches 1.. run scoreboard players operation @s fbt_panel = @s sp_hprev
title @s actionbar {text:""}
