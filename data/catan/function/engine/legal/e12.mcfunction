scoreboard players set #valid ca_ctx 0
execute unless score #eo12 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 8 unless score #setup_vertex ca_ctx matches 12 run return 0
execute if score #vo8 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo8 ca_ctx matches 0 if score #eo7 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo8 ca_ctx matches 0 if score #eo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo12 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo12 ca_ctx matches 0 if score #eo11 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo12 ca_ctx matches 0 if score #eo19 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
