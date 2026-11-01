function weiqi:name/capture
execute if score @s go_side matches 1 run data modify entity @e[tag=go.current,limit=1] data.weiqi.black_name set from storage weiqi:runtime name.value
execute if score @s go_side matches -1 run data modify entity @e[tag=go.current,limit=1] data.weiqi.white_name set from storage weiqi:runtime name.value
