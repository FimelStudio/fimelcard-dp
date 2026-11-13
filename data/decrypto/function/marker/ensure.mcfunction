# 如果实体丢失或在旧版结算时被刷到别处，用当前分数补回桌心。
scoreboard players operation #marker_table dc_ctx = @s dc_id
scoreboard players set #marker_found dc_ctx 0
execute positioned ~ ~2.55 ~ as @e[type=minecraft:text_display,tag=dc.marker,distance=..0.1] if score @s dc_id = #marker_table dc_ctx run scoreboard players set #marker_found dc_ctx 1
execute unless score #marker_found dc_ctx matches 1 run function decrypto:marker/update
