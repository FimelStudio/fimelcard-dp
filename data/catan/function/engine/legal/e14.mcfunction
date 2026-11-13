scoreboard players set #valid ca_ctx 0
execute unless score #eo14 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 9 unless score #setup_vertex ca_ctx matches 13 run return 0
execute if score #vo9 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo9 ca_ctx matches 0 if score #eo8 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo9 ca_ctx matches 0 if score #eo15 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo13 ca_ctx matches 0 if score #eo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo13 ca_ctx matches 0 if score #eo20 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
