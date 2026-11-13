data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s sp_hpanel
function fimel_title:replace_panel
execute store result storage splendor:hud panel int 1 run scoreboard players get @s sp_hpanel
function splendor:hud/forget_notice with storage splendor:hud
