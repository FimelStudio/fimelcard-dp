# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 控制器入口；状态更迭只使旧输入失效，不给其他玩家强制弹窗。
function guandan:system/context
scoreboard players set @a[tag=gd.audience] gd_action 0
scoreboard players enable @a[tag=gd.audience] gd_action
function guandan:hud/refresh
execute as @a[tag=gd.audience] run function guandan:input/sync_turn_tool
