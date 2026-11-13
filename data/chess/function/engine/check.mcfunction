# 对外非提交探测；与try_move使用相同规则但不要求游戏状态，也不改变真实局面。
function chess:system/context
function chess:engine/cache
scoreboard players set #legal ch_ctx 0
execute unless score #cache_ok ch_ctx matches 1 run return 0
execute unless score #from ch_ctx matches 0..63 run return 0
execute unless score #to ch_ctx matches 0..63 run return 0
function chess:engine/check_move
return run scoreboard players get #legal ch_ctx
