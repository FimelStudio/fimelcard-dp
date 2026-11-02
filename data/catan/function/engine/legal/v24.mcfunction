scoreboard players set #valid ca_ctx 0
execute unless score #vo24 ca_ctx matches 0 run return 0
execute unless score #vo18 ca_ctx matches 0 run return 0
execute unless score #vo19 ca_ctx matches 0 run return 0
execute unless score #vo30 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo29 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo36 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
