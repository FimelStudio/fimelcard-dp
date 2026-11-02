scoreboard players set #valid ca_ctx 0
execute unless score #eo59 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 41 unless score #setup_vertex ca_ctx matches 45 run return 0
execute if score #vo41 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo41 ca_ctx matches 0 if score #eo52 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo41 ca_ctx matches 0 if score #eo60 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo45 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo45 ca_ctx matches 0 if score #eo58 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo45 ca_ctx matches 0 if score #eo64 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
