scoreboard players set #valid ca_ctx 0
execute unless score #eo10 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 7 unless score #setup_vertex ca_ctx matches 11 run return 0
execute if score #vo7 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo7 ca_ctx matches 0 if score #eo6 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo7 ca_ctx matches 0 if score #eo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo11 ca_ctx matches 0 if score #eo18 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
