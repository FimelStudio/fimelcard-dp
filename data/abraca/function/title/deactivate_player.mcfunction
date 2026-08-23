scoreboard players set @s title.panel_id 0
execute if score @s ab_prev_panel matches 1.. run scoreboard players operation @s title.panel_id = @s ab_prev_panel
scoreboard players reset @s ab_prev_panel
