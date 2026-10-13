# 本包不再占用动作栏时恢复原面板；外部系统已重新绑定时尊重其新选择。
execute unless score @s title.panel_id matches 1.. if score @s fbt_external matches 1.. run scoreboard players operation @s title.panel_id = @s fbt_external
scoreboard players reset @s fbt_external
tag @s remove fimel.bt_paused
