data modify storage doudizhu:ui status set value {text:"手速制：前2秒×4，超过2秒至5秒×2，超过5秒至15秒×1；超时无人叫则重新发牌。",color:"gold"}
data modify storage doudizhu:ui controls append value {"label":{"text":"叫地主"},"width":160,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 207"}}
