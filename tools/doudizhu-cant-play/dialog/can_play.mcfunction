# 检查整副手牌是否存在合法应牌；检测期间保存并恢复玩家已有选择。
scoreboard players set #can_play dd_ctx 1
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run return 1
tag @e[tag=dd.ui_saved] remove dd.ui_saved
tag @e[tag=dd.hand,scores={dd_selected=1}] add dd.ui_saved
function doudizhu:bot/search
scoreboard players operation #can_play dd_ctx = #bot_found dd_ctx
scoreboard players set @e[tag=dd.hand] dd_selected 0
scoreboard players set @e[tag=dd.hand,tag=dd.ui_saved] dd_selected 1
tag @e[tag=dd.ui_saved] remove dd.ui_saved
