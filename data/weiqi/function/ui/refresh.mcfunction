# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 阶段推进只恢复trigger资格，不强制打断视角弹窗。
function weiqi:system/context
scoreboard players set @a[tag=go.audience] go_action 0
scoreboard players enable @a[tag=go.audience] go_action
