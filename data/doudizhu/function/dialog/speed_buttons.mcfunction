data modify storage doudizhu:ui status set value {text:"手速制：所有人同时可叫，首个有效提交者成为地主（基础分1）。",color:"gold"}
data modify storage doudizhu:ui controls append value {"label":{"text":"叫地主"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 207"}}
