scoreboard players set #valid ca_ctx 0
execute unless score #eo40 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 28 unless score #setup_vertex ca_ctx matches 33 run return 0
execute if score #vo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo28 ca_ctx matches 0 if score #eo34 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo28 ca_ctx matches 0 if score #eo41 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx matches 0 if score #eo39 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo33 ca_ctx matches 0 if score #eo49 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
