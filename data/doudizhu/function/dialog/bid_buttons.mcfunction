# 所有牌都可查看，只有当前叫分者的提交会被接收。
data modify storage doudizhu:ui controls append value {"label":{"text":"不叫"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 200"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"1分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 201"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"2分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 202"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"3分"},"width":52,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 203"}}
