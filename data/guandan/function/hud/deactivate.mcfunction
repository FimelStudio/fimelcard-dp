# 只清理自己曾分配的面板；若其他游戏已接管，不改其绑定及 actionbar。
execute if score @s gd_panel matches 1.. run function guandan:hud/empty
execute if entity @s[tag=gd.hud_active] if score @s fbt_panel = @s gd_panel run function guandan:hud/restore
tag @s remove gd.owns_actionbar
tag @s remove gd.hud_active
scoreboard players reset @s gd_prev_panel
