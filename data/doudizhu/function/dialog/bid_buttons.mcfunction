execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 1 run return run function doudizhu:dialog/rob_buttons
execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 2 run return run function doudizhu:dialog/speed_buttons
# 所有牌都可查看，只有当前叫分者的提交会被接收。
data modify storage doudizhu:ui controls append value {"label":{"text":"不叫"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 200"}}
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0 run data modify storage doudizhu:ui controls append value {"label":{"text":"1分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 201"}}
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0..1 run data modify storage doudizhu:ui controls append value {"label":{"text":"2分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 202"}}
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0..2 run data modify storage doudizhu:ui controls append value {"label":{"text":"3分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 203"}}
