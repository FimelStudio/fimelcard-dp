scoreboard players operation #ctx ab_ctx = @s ab_id
# 必须由控制器处理击倒结算；不能让生命归零的玩家自己调用round_finish。
function abraca:effect/check_knockout
execute if score @s ab_state matches 0 run return 0
# 只把本回合玩家补回5张；失败且仍有5张时不会额外得到第6张。
execute as @a[tag=ab.actor,limit=1] run function abraca:deck/refill
function abraca:title/update_all
function abraca:turn/begin
