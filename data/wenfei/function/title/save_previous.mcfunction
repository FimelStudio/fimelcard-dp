scoreboard players set @s wq_prev_panel 0
execute if score @s title.panel_id matches 1.. run scoreboard players operation @s wq_prev_panel = @s title.panel_id
