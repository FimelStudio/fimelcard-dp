scoreboard players set #valid ca_ctx 0
execute unless score #eo54 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 38 unless score #setup_vertex ca_ctx matches 43 run return 0
execute if score #vo38 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo38 ca_ctx matches 0 if score #eo49 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo43 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo43 ca_ctx matches 0 if score #eo55 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo43 ca_ctx matches 0 if score #eo62 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
