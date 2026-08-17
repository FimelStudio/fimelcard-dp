# 恢复牌的选项顺序与公开弃牌堆完全一致
execute as @e[type=minecraft:marker,tag=hb.discard] if score @s hb_id = #ctx_id hb_ctx if score @s hb_discard_order = #discard_scan hb_ctx run function hanabi:dialog/restore/append
scoreboard players add #discard_scan hb_ctx 1
execute if score #discard_scan hb_ctx <= #discard_max hb_ctx run function hanabi:dialog/restore/scan
