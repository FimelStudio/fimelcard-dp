# 恢复进入谍报风云前的BetterTitle面板；没有旧面板时归还原版Actionbar。
scoreboard players set @s fbt_panel 0
execute if score @s dc_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s dc_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s dc_prev_panel
execute if entity @s[tag=dc.owns_actionbar_block] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove dc.owns_actionbar_block
