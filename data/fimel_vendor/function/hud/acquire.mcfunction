# 只有外部 BetterTitle 真的绑定了面板时才暂时停止它的发送。
execute unless entity @s[tag=fimel.bt_paused] if score @s title.panel_id matches 1.. run function fimel_vendor:hud/save_external
execute if entity @s[tag=fimel.bt_paused] run scoreboard players set @s title.panel_id 0
