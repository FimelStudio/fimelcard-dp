function weiqi:system/context
# 声源固定在本桌，仅发送给仍在本桌入座的参与者。
execute at @s positioned ~ ~1 ~ as @a[tag=go.audience] if score @s ct_id = #table go_ctx if score @s go_table = #table go_ctx run playsound card:weiqi.move block @s ~ ~ ~ 0.6 1 0
