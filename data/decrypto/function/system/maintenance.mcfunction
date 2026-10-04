scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players set #online dc_ctx 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players add #online dc_ctx 1
# 老版本只支持三/四人，用原模式补入开局人数，不改回合和角色。
execute unless data entity @s data.decrypto.player_count store result entity @s data.decrypto.player_count int 1 run scoreboard players get @s dc_mode
execute store result score #expected dc_ctx run data get entity @s data.decrypto.player_count
execute unless score #online dc_ctx = #expected dc_ctx run function decrypto:game/abort
