# 基础启发式：离对方前方六格的外环落点容易被下一次掷骰追上。
# 不另抽骰，不改真实棋面；捕获收益仍优先于轻量风险扣分。
execute as @e[tag=ac.board,scores={ac_pos=1..51,ac_active=1}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:ai/risk_one
