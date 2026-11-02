# 回合变化才同步物品；回合外的 UNO 与 +4 响应独立于手牌道具。
function uno:system/context
dialog clear @a[tag=un.audience]
scoreboard players set @a[tag=un.audience] un_pick -1
scoreboard players set @a[tag=un.audience] un_colorpick -1
scoreboard players set @a[tag=un.audience] un_action 0
scoreboard players enable @a[tag=un.audience] un_action
execute as @a[tag=un.audience] run function uno:input/give
execute if score @s un_state matches 3..4 as @a[tag=un.audience] run function uno:ui/response_prepare
