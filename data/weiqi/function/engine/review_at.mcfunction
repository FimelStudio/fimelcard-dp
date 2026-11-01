$execute unless data entity @s data.weiqi.history[$(frame)] run return 0
$data modify storage weiqi:runtime snapshot set from entity @s data.weiqi.history[$(frame)]
function weiqi:engine/restore
scoreboard players set #ok go_ctx 1
