# 每人只选一个牌型；重复点击取消，点另一牌型直接转移亮框。
# 是否持有、是否本回合新摸牌仍由核心在真正出牌时复验。
scoreboard players operation #ui_selection un_ctx = #ui_action un_ctx
scoreboard players remove #ui_selection un_ctx 100
execute if score @s un_pick = #ui_selection un_ctx run return run function uno:input/deselect
scoreboard players operation @s un_pick = #ui_selection un_ctx
function uno:ui/open
