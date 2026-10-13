# 防止外部 BetterTitle 与本包对同一玩家交替覆盖 Actionbar。
function fimel_vendor:hud/acquire

execute store result storage fimel_title:io panel_id int 1.0 run scoreboard players get @s fbt_panel

function fimel_title:code/display_macro with storage fimel_title:io