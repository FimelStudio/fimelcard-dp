scoreboard players set #valid ca_ctx 0
execute unless score #eo34 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 22 unless score #setup_vertex ca_ctx matches 28 run return 0
execute if score #vo22 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo22 ca_ctx matches 0 if score #eo24 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo22 ca_ctx matches 0 if score #eo25 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo28 ca_ctx matches 0 if score #eo40 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo28 ca_ctx matches 0 if score #eo41 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
