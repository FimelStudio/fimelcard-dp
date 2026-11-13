scoreboard players set #valid ca_ctx 0
execute unless score #vo17 ca_ctx matches 0 run return 0
execute unless score #vo12 ca_ctx matches 0 run return 0
execute unless score #vo22 ca_ctx matches 0 run return 0
execute unless score #vo23 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo19 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo25 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo26 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
