# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 一次摸多张只在刻末刷新一次 HUD 和公开名单。
execute unless score @s un_hud_dirty matches 1 run return 0
execute unless score @s un_state matches 1..5 run return 0
function uno:hud/refresh
function uno:visual/update_status
