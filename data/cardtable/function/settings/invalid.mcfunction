tellraw @s {text:"[牌桌] 游戏设置已过期，请重新打开。",color:"yellow"}
function cardtable:settings/clear_session
tag @e[tag=ct.setting_controller] remove ct.setting_controller
