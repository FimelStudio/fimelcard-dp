scoreboard players set #valid ca_ctx 0
execute unless score #eo22 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 15 unless score #setup_vertex ca_ctx matches 20 run return 0
execute if score #vo15 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo15 ca_ctx matches 0 if score #eo17 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo20 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo20 ca_ctx matches 0 if score #eo31 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo20 ca_ctx matches 0 if score #eo32 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
