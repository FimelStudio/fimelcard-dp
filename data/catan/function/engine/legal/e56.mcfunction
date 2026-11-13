scoreboard players set #valid ca_ctx 0
execute unless score #eo56 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 39 unless score #setup_vertex ca_ctx matches 44 run return 0
execute if score #vo39 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo39 ca_ctx matches 0 if score #eo50 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo39 ca_ctx matches 0 if score #eo55 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo44 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo44 ca_ctx matches 0 if score #eo57 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo44 ca_ctx matches 0 if score #eo63 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
