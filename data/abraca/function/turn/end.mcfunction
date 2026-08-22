scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches ..0 run function abraca:game/round_finish
execute if score @s ab_state matches 0 run return 0
# 只把本回合玩家补回5张；失败且仍有5张时不会额外得到第6张。
execute as @a[tag=ab.actor,limit=1] run function abraca:deck/refill
function abraca:turn/begin
