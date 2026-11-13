function love_letter:system/context
# 声源固定在本桌，仅发送给仍在本桌入座的参与者。
execute at @s positioned ~ ~1 ~ as @a[tag=ll.audience] if score @s ct_id = #table ll_ctx if score @s ll_table = #table ll_ctx run playsound card:love_letter.round_win block @s ~ ~ ~ 0.6 1 0
