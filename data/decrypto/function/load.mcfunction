scoreboard objectives add dc_ctx dummy
execute unless score #version dc_ctx matches 1.. run function decrypto:system/install
execute if score #version dc_ctx matches 1 run function decrypto:system/upgrade_v2
execute if score #version dc_ctx matches 2 run function decrypto:system/upgrade_v3
execute if score #version dc_ctx matches 3 run function decrypto:system/upgrade_v4
execute if score #version dc_ctx matches 4 run function decrypto:system/upgrade_v5
execute if score #version dc_ctx matches 5 run function decrypto:system/upgrade_v6
execute if score #version dc_ctx matches 6 run function decrypto:system/upgrade_v7
execute if score #version dc_ctx matches 7 run function decrypto:system/upgrade_v8
execute if score #version dc_ctx matches 8 run function decrypto:system/upgrade_v9
execute if score #version dc_ctx matches 9 run function decrypto:system/upgrade_v10
function decrypto:title/ensure_library
tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'数据包已重新加载，当前游戏将安全结束。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=dc.controller] at @s run function decrypto:game/abort
