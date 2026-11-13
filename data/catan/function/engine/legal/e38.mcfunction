scoreboard players set #valid ca_ctx 0
execute unless score #eo38 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 26 unless score #setup_vertex ca_ctx matches 32 run return 0
execute if score #vo26 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo26 ca_ctx matches 0 if score #eo32 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo32 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo32 ca_ctx matches 0 if score #eo48 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
