scoreboard players set #valid ca_ctx 0
scoreboard players operation #cost ca_ctx = #ratio ca_ctx
scoreboard players operation #cost ca_ctx *= #b ca_ctx
$execute if score #r$(target) ca_ctx < #cost ca_ctx run return 0
$execute if score #bank$(a) ca_ctx < #b ca_ctx run return 0
$scoreboard players operation #r$(target) ca_ctx -= #cost ca_ctx
$scoreboard players operation #bank$(target) ca_ctx += #cost ca_ctx
$scoreboard players operation #r$(a) ca_ctx += #b ca_ctx
$scoreboard players operation #bank$(a) ca_ctx -= #b ca_ctx
scoreboard players set #valid ca_ctx 1
