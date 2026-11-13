# 仅清 UNO 自己的面板；别的游戏或外部面板已经接管时不覆盖它。
execute if score @s un_panel matches 1.. run function uno:hud/empty
execute if entity @s[tag=un.hud_active] if score @s fbt_panel = @s un_panel run function uno:hud/restore
execute if entity @s[tag=un.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove un.owns_actionbar
tag @s remove un.hud_active
scoreboard players reset @s un_prev_panel
