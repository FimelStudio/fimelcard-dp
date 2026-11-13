scoreboard players set #valid ca_ctx 0
execute unless score #eo69 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 49 unless score #setup_vertex ca_ctx matches 52 run return 0
execute if score #vo49 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo49 ca_ctx matches 0 if score #eo64 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo49 ca_ctx matches 0 if score #eo70 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo52 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo52 ca_ctx matches 0 if score #eo68 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
