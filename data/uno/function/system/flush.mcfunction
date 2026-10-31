# 一次摸多张只在刻末刷新一次 HUD 和公开名单。
execute unless score @s un_hud_dirty matches 1 run return 0
execute unless score @s un_state matches 1..5 run return 0
function uno:hud/refresh
function uno:visual/update_status
