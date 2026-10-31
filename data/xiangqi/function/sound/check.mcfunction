# 固定牌桌为声源，只发送给仍属于本桌的玩家。
function xiangqi:system/context
execute at @s positioned ~ ~1 ~ as @a[tag=xq.audience] if score @s ct_id = #table xq_ctx if score @s xq_table = #table xq_ctx run playsound card:xiangqi.check block @s ~ ~ ~ 0.75 1 0
