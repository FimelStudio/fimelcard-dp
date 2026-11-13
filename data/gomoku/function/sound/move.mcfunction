# 固定本桌为声源；非法输入仅反馈操作者。
function gomoku:system/context
execute at @s positioned ~ ~1 ~ as @a[tag=gm.audience] if score @s ct_id = #table gm_ctx if score @s gm_table = #table gm_ctx run playsound card:gomoku.move block @s ~ ~ ~ 0.65 1 0
