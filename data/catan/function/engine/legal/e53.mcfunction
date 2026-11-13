scoreboard players set #valid ca_ctx 0
execute unless score #eo53 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 37 unless score #setup_vertex ca_ctx matches 42 run return 0
execute if score #vo37 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo37 ca_ctx matches 0 if score #eo47 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo37 ca_ctx matches 0 if score #eo48 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo42 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo42 ca_ctx matches 0 if score #eo61 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
