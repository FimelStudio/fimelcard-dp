scoreboard players set #valid ca_ctx 0
execute unless score #vo7 ca_ctx matches 0 run return 0
execute unless score #vo3 ca_ctx matches 0 run return 0
execute unless score #vo11 ca_ctx matches 0 run return 0
execute unless score #vo12 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo6 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo10 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
