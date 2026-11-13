scoreboard players set #valid ca_ctx 0
execute unless score #eo66 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 47 unless score #setup_vertex ca_ctx matches 51 run return 0
execute if score #vo47 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo47 ca_ctx matches 0 if score #eo62 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo51 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo51 ca_ctx matches 0 if score #eo67 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
