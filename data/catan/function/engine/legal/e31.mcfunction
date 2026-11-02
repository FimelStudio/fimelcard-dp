scoreboard players set #valid ca_ctx 0
execute unless score #eo31 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 20 unless score #setup_vertex ca_ctx matches 25 run return 0
execute if score #vo20 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo20 ca_ctx matches 0 if score #eo22 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo20 ca_ctx matches 0 if score #eo32 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo25 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo25 ca_ctx matches 0 if score #eo30 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo25 ca_ctx matches 0 if score #eo37 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
