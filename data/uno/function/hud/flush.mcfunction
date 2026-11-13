# take 只置脏；多张罚摸或起手同一刻最多刷新一次，避免重复扫牌。
execute if score @s un_hud_dirty matches 1 if score @s un_state matches 1..5 run function uno:hud/refresh
