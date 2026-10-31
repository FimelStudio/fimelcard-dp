# 声源固定在控制器上方，仅本桌仍入座的双方接收。
function chess:system/context
execute at @s positioned ~ ~1 ~ as @a[tag=ch.audience] if score @s ct_id = #table ch_ctx if score @s ch_table = #table ch_ctx run playsound card:chess.move block @s ~ ~ ~ 0.65 1 0
