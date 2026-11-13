tellraw @s {text:"[牌桌] 椅子设置已过期，请重新打开游戏设置。",color:"yellow"}
function cardtable:chairs/settings/clear_session
tag @e[tag=ct.chair_controller] remove ct.chair_controller
