# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
# uninstall-guard: end
scoreboard objectives add dd_classic_bid dummy
scoreboard objectives add dd_scoring dummy
scoreboard objectives add dd_hide_score dummy
scoreboard objectives add dd_void dummy
scoreboard objectives add dd_pred_phase dummy
scoreboard objectives add dd_pred_round dummy
scoreboard objectives add dd_pred_token dummy
scoreboard objectives add dd_prediction dummy
scoreboard objectives add dd_lane dummy
scoreboard objectives add dd_team_one dummy
scoreboard objectives add dd_team_two dummy
scoreboard objectives add dd_side_score dummy
scoreboard objectives add dd_pair_scored dummy
scoreboard objectives add dd_team dummy
scoreboard objectives add dd_bidbye dummy
scoreboard objectives add dd_out dummy
scoreboard objectives add dd_noshuffle dummy
scoreboard objectives add dd_deckpos dummy
function doudizhu:visual/load
scoreboard objectives add dd_speed_time dummy
scoreboard objectives add dd_counter dummy
scoreboard objectives add dd_bidmode dummy
scoreboard objectives add dd_bidphase dummy
scoreboard objectives add dd_firstcall dummy
scoreboard objectives add dd_bidleft dummy
scoreboard objectives add dd_eligible dummy
scoreboard objectives add dd_counts dummy
scoreboard objectives add dd_autopass dummy
scoreboard objectives add dd_auto_seat dummy
scoreboard objectives add dd_audio dummy
scoreboard objectives add dd_ctx dummy
execute unless score #version dd_ctx matches 1.. run function doudizhu:system/install
execute if score #version dd_ctx matches 1 run function doudizhu:system/upgrade_v2
# 重载保留牌局；重新启用操作入口并恢复手牌显示。
execute as @a[tag=dd.player] run scoreboard players enable @s dd_action

execute if score #version dd_ctx matches 2 run function doudizhu:system/upgrade_v3
execute if score #version dd_ctx matches 3 run function doudizhu:system/upgrade_v4
scoreboard players reset * dd_settings
scoreboard players reset * dd_set_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=10}] run function doudizhu:game/init_table
execute as @e[type=minecraft:marker,tag=dd.controller] run function doudizhu:game/ensure_match
execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute as @e[type=minecraft:marker,tag=dd.controller] run function doudizhu:input/sync

function doudizhu:music/load
execute as @a[tag=dd.player] run function doudizhu:input/refresh_model
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_lane=1..2}] run function doudizhu:visual/clear
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_lane=1,dd_pred_phase=1}] run function doudizhu:predict/restore
