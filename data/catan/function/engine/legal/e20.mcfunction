scoreboard players set #valid ca_ctx 0
execute unless score #eo20 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 13 unless score #setup_vertex ca_ctx matches 18 run return 0
execute if score #vo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo13 ca_ctx matches 0 if score #eo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo13 ca_ctx matches 0 if score #eo14 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo18 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo18 ca_ctx matches 0 if score #eo27 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo18 ca_ctx matches 0 if score #eo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
