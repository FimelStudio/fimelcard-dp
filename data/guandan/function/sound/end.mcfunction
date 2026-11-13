function guandan:system/context
# 声源固定在本桌，仅发送给仍在本桌入座的参与者。
execute at @s positioned ~ ~1 ~ as @a[tag=gd.audience] if score @s ct_id = #table gd_ctx if score @s gd_table = #table gd_ctx run playsound card:guandan.end block @s ~ ~ ~ 0.6 1 0
