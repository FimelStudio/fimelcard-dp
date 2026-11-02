scoreboard players set #valid ca_ctx 0
execute unless score #vo16 ca_ctx matches 0 run return 0
execute unless score #vo11 ca_ctx matches 0 run return 0
execute unless score #vo21 ca_ctx matches 0 run return 0
execute unless score #vo22 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo18 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo24 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
