# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 更新可用输入，不逐刻强制弹窗。
function gomoku:system/context
scoreboard players set @a[tag=gm.audience] gm_action 0
scoreboard players enable @a[tag=gm.audience] gm_action
