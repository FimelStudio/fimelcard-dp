function magical_athlete:settings/clear_session
tellraw @s {text:"[胡闹运动会] 设置窗口已过期，请重新打开。",color:"yellow"}
tag @e[tag=ma.setting_table] remove ma.setting_table
