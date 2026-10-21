function doudizhu:dialog/can_play
execute if score #can_play dd_ctx matches 1 run data modify storage doudizhu:ui controls append value {"label":{"text":"出牌"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 100"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"不出"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 101"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"清空选择"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 102"}}
execute if score #can_play dd_ctx matches 0 if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run data modify storage doudizhu:ui status set value {text:"要不起：手牌中没有能压过上一手的组合，本回合等待5秒后自动不出，也可立即选择“不出”。",color:"yellow"}
