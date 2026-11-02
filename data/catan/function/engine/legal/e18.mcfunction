scoreboard players set #valid ca_ctx 0
execute unless score #eo18 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 11 unless score #setup_vertex ca_ctx matches 16 run return 0
execute if score #vo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo11 ca_ctx matches 0 if score #eo10 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo16 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo16 ca_ctx matches 0 if score #eo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo16 ca_ctx matches 0 if score #eo24 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
