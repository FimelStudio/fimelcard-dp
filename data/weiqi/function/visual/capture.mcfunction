function weiqi:visual/context
data modify storage weiqi:visual captured set value []
data modify storage weiqi:visual captured set from entity @s data.weiqi.last.captured
execute if data storage weiqi:visual captured[0] run function weiqi:visual/capture_loop
