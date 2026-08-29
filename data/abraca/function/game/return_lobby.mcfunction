# 结算展示结束后，清除本桌静态血量面板并恢复通用游戏选择界面。
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @e[type=minecraft:text_display,tag=ab.final_info] if score @s ab_id = #ctx ab_ctx run kill @s
tag @s remove ab.controller
scoreboard players set @s ab_state 0
scoreboard players reset @s ab_id
function cardtable:game/return_lobby
