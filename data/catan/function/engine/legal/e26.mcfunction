scoreboard players set #valid ca_ctx 0
execute unless score #eo26 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 17 unless score #setup_vertex ca_ctx matches 23 run return 0
execute if score #vo17 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo17 ca_ctx matches 0 if score #eo19 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo17 ca_ctx matches 0 if score #eo25 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo23 ca_ctx matches 0 if score #eo27 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo23 ca_ctx matches 0 if score #eo35 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
