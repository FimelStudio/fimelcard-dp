scoreboard players set #valid ca_ctx 0
execute unless score #eo39 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 27 unless score #setup_vertex ca_ctx matches 33 run return 0
execute if score #vo27 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo27 ca_ctx matches 0 if score #eo33 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx matches 0 if score #eo40 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx matches 0 if score #eo49 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
