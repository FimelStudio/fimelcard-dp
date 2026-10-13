scoreboard players set @s ab_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s ab_prev_panel = @s fbt_panel
function fimel_title:new_panel {id:"@s ab_panel"}
scoreboard players operation @s fbt_panel = @s ab_panel
