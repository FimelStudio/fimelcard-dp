function splendor:settings/clear_session
tellraw @s {text:"[璀璨宝石] 设置窗口已过期，请重新打开。",color:"yellow"}
tag @e[tag=sp.setting_table] remove sp.setting_table
