# 旧设置窗口编码已停用，新界面使用公共一次性会话。
scoreboard players reset @s dc_settings
tellraw @s {text:"[牌桌] 设置界面已更新，请重新打开游戏设置。",color:"yellow"}
return 0
