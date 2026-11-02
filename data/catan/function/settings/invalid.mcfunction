function catan:settings/clear_session
tellraw @s {text:"[卡坦岛] 设置窗口已过期，请重新打开。",color:"yellow"}
tag @e[tag=ca.setting_table] remove ca.setting_table
