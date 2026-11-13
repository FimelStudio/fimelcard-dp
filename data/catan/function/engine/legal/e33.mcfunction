scoreboard players set #valid ca_ctx 0
execute unless score #eo33 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 21 unless score #setup_vertex ca_ctx matches 27 run return 0
execute if score #vo21 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo21 ca_ctx matches 0 if score #eo23 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo27 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo27 ca_ctx matches 0 if score #eo39 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
