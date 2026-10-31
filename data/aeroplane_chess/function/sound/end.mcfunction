# 固定本桌为声源；非法输入仅反馈操作者。
function aeroplane_chess:system/context
execute at @s positioned ~ ~1 ~ as @a[tag=ac.audience] if score @s ct_id = #table ac_ctx if score @s ac_table = #table ac_ctx run playsound card:aeroplane_chess.end block @s ~ ~ ~ 0.65 1 0
