# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_lane=1}] run function doudizhu:duplicate/pause_sync
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=2,dd_bidmode=2}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:bid/speed_tick
execute as @a[scores={dd_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:settings/save
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=4,dd_lane=1}] unless score @s ct_paused matches 1 at @s run function doudizhu:duplicate/tick
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=4}] unless score @s dd_lane matches 1..2 unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:game/intermission
execute as @e[type=minecraft:item,tag=!ct.paused_return] if items entity @s contents *[minecraft:custom_data~{doudizhu:{prediction_tool:1b}}] run function doudizhu:predict/drop
execute as @a[tag=dd.player,scores={dd_drop_dye=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:input/drop
execute as @a[tag=dd.player,scores={dd_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:action/handle
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:deal/tick
# 两个分桌错开人机搜索，避免同一刻同时展开两手牌的候选。
scoreboard players add #bot_lane dd_ctx 1
execute if score #bot_lane dd_ctx matches 3.. run scoreboard players set #bot_lane dd_ctx 1
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=2..3}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:bot/tick
scoreboard players add #clock dd_ctx 1
execute if score #clock dd_ctx matches 20.. as @a[tag=dd.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:player/check_session
execute if score #clock dd_ctx matches 20.. as @e[type=minecraft:marker,tag=dd.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:system/maintenance
execute if score #clock dd_ctx matches 20.. run scoreboard players set #clock dd_ctx 0

execute as @e[type=minecraft:marker,tag=dd.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function doudizhu:input/sync

execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=3}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:autopass/tick
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=2..3,dd_turn_clock=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function doudizhu:clock/tick
function doudizhu:music/tick
