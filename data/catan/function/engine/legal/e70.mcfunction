scoreboard players set #valid ca_ctx 0
execute unless score #eo70 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 49 unless score #setup_vertex ca_ctx matches 53 run return 0
execute if score #vo49 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo49 ca_ctx matches 0 if score #eo64 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo49 ca_ctx matches 0 if score #eo69 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo53 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo53 ca_ctx matches 0 if score #eo71 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
