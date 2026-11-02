scoreboard players set #valid ca_ctx 0
execute unless score #eo45 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 30 unless score #setup_vertex ca_ctx matches 36 run return 0
execute if score #vo30 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo30 ca_ctx matches 0 if score #eo36 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo30 ca_ctx matches 0 if score #eo44 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo36 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo36 ca_ctx matches 0 if score #eo46 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo36 ca_ctx matches 0 if score #eo52 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
