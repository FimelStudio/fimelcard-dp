# 一个玩家只分配一个可重用的 UNO 面板，退出时清空该面板。
execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=un.hud_active] run return 0
scoreboard players set @s un_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s un_prev_panel = @s fbt_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add un.owns_actionbar
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s un_panel"}
tag @s add un.hud_active
