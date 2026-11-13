data modify entity @s data.weiqi.black_name set value {text:"基础人机",color:"aqua"}
data modify entity @s data.weiqi.white_name set value {text:"基础人机",color:"aqua"}
execute as @a[tag=go.audience] run function weiqi:player/capture_name
