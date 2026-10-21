data modify storage doudizhu:ui status set value {text:"叫抢制：叫地主不翻倍；每次抢地主×2。第二轮仅第一轮叫过或抢过的人参与，抢则立即确定地主，最后一人自动获选。",color:"gold"}
execute if score @e[tag=dd.current,limit=1] dd_bidphase matches 1 run data modify storage doudizhu:ui status set value {text:"第二轮：选择抢立即成为地主并×2；选择不要则让下一位选择，最后一人自动成为地主、不翻倍。",color:"gold"}
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0 run data modify storage doudizhu:ui controls append value {"label":{"text":"叫地主"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 204"}}
execute if score @e[tag=dd.current,limit=1] dd_bid matches 1.. run data modify storage doudizhu:ui controls append value {"label":{"text":"抢地主 ×2"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 205"}}
data modify storage doudizhu:ui controls append value {"label":{"text":"不叫"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger dd_action set 206"}}
