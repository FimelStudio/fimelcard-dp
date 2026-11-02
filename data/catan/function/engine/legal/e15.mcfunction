scoreboard players set #valid ca_ctx 0
execute unless score #eo15 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 9 unless score #setup_vertex ca_ctx matches 14 run return 0
execute if score #vo9 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo9 ca_ctx matches 0 if score #eo8 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo9 ca_ctx matches 0 if score #eo14 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo14 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo14 ca_ctx matches 0 if score #eo16 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo14 ca_ctx matches 0 if score #eo21 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
