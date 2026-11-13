# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
# uninstall-guard: end
scoreboard objectives add bw_ctx dummy
execute unless score #version bw_ctx matches 1.. run function bullshit:system/install
execute if score #version bw_ctx matches 1 run function bullshit:system/upgrade_v2
execute as @e[type=minecraft:marker,tag=bw.controller] at @s run function bullshit:game/resume
