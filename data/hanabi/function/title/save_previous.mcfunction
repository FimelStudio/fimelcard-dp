# 只在首次接管该玩家Actionbar时保存原面板，重载时不得用花火面板覆盖备份。
scoreboard players set @s hb_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s hb_prev_panel = @s fbt_panel
