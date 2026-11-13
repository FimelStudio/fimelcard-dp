scoreboard players set #valid ca_ctx 0
$execute unless score #dev$(target) ca_ctx matches 1.. run return 0
$scoreboard players remove #dev$(target) ca_ctx 1
$execute store result score #discarded ca_ctx run data get storage catan:engine state.dev_discard[$(target)]
execute unless score #target ca_ctx matches 0 run scoreboard players add #discarded ca_ctx 1
$execute store result storage catan:engine state.dev_discard[$(target)] int 1 run scoreboard players get #discarded ca_ctx
scoreboard players set #valid ca_ctx 1
