# 只在首次接管时保存进入谍报风云前的面板。
scoreboard players set @s dc_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s dc_prev_panel = @s fbt_panel
