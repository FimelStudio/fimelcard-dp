# 清空本游戏面板内容，防止重连或外部误绑后再次显示旧手牌。
execute if score @s ab_panel matches 1.. run function abraca:title/clear_panel
# 只归还自己占用的面板，不覆盖已经接管的其他 HUD。
execute if score @s fbt_panel = @s ab_panel run function abraca:title/restore_player
scoreboard players reset @s ab_prev_panel
