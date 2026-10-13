
execute store result storage fimel_title:io panel_id int 1.0 run scoreboard players get panel_id fbt_io
function fimel_title:code/replace_panel_macro with storage fimel_title:io
data modify storage fimel_title:io panel_buffer set value []

