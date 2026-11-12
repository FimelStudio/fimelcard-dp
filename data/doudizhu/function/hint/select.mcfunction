execute if score @e[tag=dd.current,limit=1] dd_autopass matches 1..100 run return 0
scoreboard players set #hint_cursor dd_ctx 0
scoreboard players operation #hint_cursor dd_ctx = @e[tag=dd.current,limit=1] dd_hint
scoreboard players set #hint_first dd_ctx 2147483647
scoreboard players set #hint_next dd_ctx 2147483647
tag @e[tag=dd.hand] remove dd.hint_first
tag @e[tag=dd.hand] remove dd.ui_saved
tag @e[tag=dd.hand,scores={dd_selected=1}] add dd.ui_saved
scoreboard players set #bot_probe dd_ctx 2
function doudizhu:bot/search
scoreboard players set #bot_probe dd_ctx 0
# 搜索已经应用后继。没有后继时，回到本手最小的候选。
execute if score #hint_next dd_ctx matches 2147483647 if score #hint_first dd_ctx matches ..2147483646 run scoreboard players set @e[tag=dd.hand,tag=dd.hint_first] dd_selected 1
execute if score #hint_next dd_ctx matches 2147483647 run scoreboard players operation #hint_next dd_ctx = #hint_first dd_ctx
execute if score #hint_next dd_ctx matches ..2147483646 run scoreboard players operation @e[tag=dd.current,limit=1] dd_hint = #hint_next dd_ctx
execute if score #hint_next dd_ctx matches 2147483647 run scoreboard players set @e[tag=dd.hand,tag=dd.ui_saved] dd_selected 1
tag @e[tag=dd.hand] remove dd.hint_first
tag @e[tag=dd.hand] remove dd.ui_saved
