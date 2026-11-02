scoreboard players set #valid ca_ctx 0
execute unless score #eo24 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 16 unless score #setup_vertex ca_ctx matches 22 run return 0
execute if score #vo16 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo16 ca_ctx matches 0 if score #eo18 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo16 ca_ctx matches 0 if score #eo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo22 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo22 ca_ctx matches 0 if score #eo25 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo22 ca_ctx matches 0 if score #eo34 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
