scoreboard players set #valid ca_ctx 0
$execute unless score #bank$(a) ca_ctx matches 1.. run return 0
$execute unless score #bank$(b) ca_ctx matches 1.. run return 0
$execute if score #a ca_ctx = #b ca_ctx unless score #bank$(a) ca_ctx matches 2.. run return 0
$scoreboard players remove #bank$(a) ca_ctx 1
$scoreboard players remove #bank$(b) ca_ctx 1
$scoreboard players add #r$(a) ca_ctx 1
$scoreboard players add #r$(b) ca_ctx 1
scoreboard players set #valid ca_ctx 1
