scoreboard players set #valid ca_ctx 0
execute unless score #eo29 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches 19 unless score #setup_vertex ca_ctx matches 24 run return 0
execute if score #vo19 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo19 ca_ctx matches 0 if score #eo21 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo19 ca_ctx matches 0 if score #eo30 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo24 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo24 ca_ctx matches 0 if score #eo28 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #vo24 ca_ctx matches 0 if score #eo36 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
