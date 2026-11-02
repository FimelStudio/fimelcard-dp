scoreboard players set #valid ca_ctx 0
execute unless score #eo35 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 23 unless score #setup_vertex ca_ctx matches 29 run return 0
execute if score #vo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo23 ca_ctx matches 0 if score #eo26 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo23 ca_ctx matches 0 if score #eo27 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo29 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo29 ca_ctx matches 0 if score #eo42 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo29 ca_ctx matches 0 if score #eo43 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
