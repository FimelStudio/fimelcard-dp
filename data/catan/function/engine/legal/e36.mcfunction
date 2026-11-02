scoreboard players set #valid ca_ctx 0
execute unless score #eo36 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 24 unless score #setup_vertex ca_ctx matches 30 run return 0
execute if score #vo24 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo24 ca_ctx matches 0 if score #eo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo24 ca_ctx matches 0 if score #eo29 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo30 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo30 ca_ctx matches 0 if score #eo44 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo30 ca_ctx matches 0 if score #eo45 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
