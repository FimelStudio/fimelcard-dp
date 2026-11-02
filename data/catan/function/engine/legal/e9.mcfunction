scoreboard players set #valid ca_ctx 0
execute unless score #eo9 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 6 unless score #setup_vertex ca_ctx matches 10 run return 0
execute if score #vo6 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo6 ca_ctx matches 0 if score #eo5 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo10 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo10 ca_ctx matches 0 if score #eo16 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo10 ca_ctx matches 0 if score #eo17 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
