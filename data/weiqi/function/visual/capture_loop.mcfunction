data modify storage weiqi:visual sq set from storage weiqi:visual captured[0]
function weiqi:visual/capture_one with storage weiqi:visual
data remove storage weiqi:visual captured[0]
execute if data storage weiqi:visual captured[0] run function weiqi:visual/capture_loop
