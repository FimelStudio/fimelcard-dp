scoreboard players set @s ab_prev_panel 0
execute if score @s title.panel_id matches 1.. run scoreboard players operation @s ab_prev_panel = @s title.panel_id
function title:new_panel {id:"@s ab_panel"}
scoreboard players operation @s title.panel_id = @s ab_panel
