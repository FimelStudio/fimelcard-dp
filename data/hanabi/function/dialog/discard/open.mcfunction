# 回合Dialog入口；弃牌堆只在请求时按时间序号构造，不增加逐刻遍历
scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
scoreboard players operation #ctx_id hb_ctx = @s hb_id
function hanabi:dialog/discard/build
function hanabi:dialog/discard/show with storage hanabi:dialog
