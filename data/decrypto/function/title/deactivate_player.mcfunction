# 恢复进入谍报风云前的BetterTitle面板；没有旧面板时归还原版Actionbar。
scoreboard players set @s title.panel_id 0
execute if score @s dc_prev_panel matches 1.. run scoreboard players operation @s title.panel_id = @s dc_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s dc_prev_panel
execute if entity @s[tag=dc.owns_actionbar_block] run tag @s remove cgt_anim_text.replace.actionbar
tag @s remove dc.owns_actionbar_block
