scoreboard players set #valid ca_ctx 0
execute unless score #eo6 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 3 unless score #setup_vertex ca_ctx matches 7 run return 0
execute if score #vo3 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo3 ca_ctx matches 0 if score #eo0 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo7 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo7 ca_ctx matches 0 if score #eo10 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo7 ca_ctx matches 0 if score #eo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
