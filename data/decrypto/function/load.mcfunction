# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
# uninstall-guard: end
scoreboard objectives add dc_sync dummy
scoreboard objectives add dc_ctx dummy
scoreboard objectives add dc_gp dummy
scoreboard objectives add dc_gr dummy
scoreboard objectives add dc_g1 dummy
scoreboard objectives add dc_g2 dummy
scoreboard objectives add dc_g3 dummy
scoreboard objectives add dc_gserial dummy
scoreboard objectives add dc_hint dummy
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
execute if score #version dc_ctx matches 10 run function decrypto:system/upgrade_v11
execute if score #version dc_ctx matches 11 run function decrypto:system/upgrade_v12
execute if score #version dc_ctx matches 12 run function decrypto:system/upgrade_v13
execute if score #version dc_ctx matches 13 run function decrypto:system/upgrade_v14
function decrypto:title/ensure_library
execute as @e[type=minecraft:marker,tag=dc.controller] at @s run function decrypto:game/resume
