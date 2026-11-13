# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 每人只选一个牌型；重复点击取消，点另一牌型直接转移亮框。
# 是否持有、是否本回合新摸牌仍由核心在真正出牌时复验。
scoreboard players operation #ui_selection un_ctx = #ui_action un_ctx
scoreboard players remove #ui_selection un_ctx 100
execute if score @s un_pick = #ui_selection un_ctx run return run function uno:input/deselect
scoreboard players operation @s un_pick = #ui_selection un_ctx
function uno:ui/open
