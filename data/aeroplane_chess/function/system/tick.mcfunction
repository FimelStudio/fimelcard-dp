function aeroplane_chess:system/context
# 同一刻只执行起始阶段，骰子落稳或段落切换不重复推进。
scoreboard players operation #tick_state ac_ctx = @s ac_state
execute if score #tick_state ac_ctx matches 2 run function aeroplane_chess:game/dice_tick
execute if score #tick_state ac_ctx matches 4 run function aeroplane_chess:game/move_tick
execute if score #tick_state ac_ctx matches 5 run function aeroplane_chess:game/result_tick
execute if score #tick_state ac_ctx matches 6 run function aeroplane_chess:game/capture_tick
execute if score #tick_state ac_ctx matches 1 run function aeroplane_chess:ai/tick
execute if score #tick_state ac_ctx matches 3 run function aeroplane_chess:ai/tick
scoreboard players add @s ac_pulse 1
execute if score @s ac_pulse matches 20.. run function aeroplane_chess:system/heartbeat
