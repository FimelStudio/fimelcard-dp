scoreboard players set #ok go_ctx 0
execute unless data entity @s data.weiqi.history[1] run return 0
data remove entity @s data.weiqi.history[-1]
data remove entity @s data.weiqi.positions[-1]
data modify storage weiqi:runtime snapshot set from entity @s data.weiqi.history[-1]
function weiqi:engine/restore
scoreboard players set #ok go_ctx 1
