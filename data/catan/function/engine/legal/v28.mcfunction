scoreboard players set #valid ca_ctx 0
execute unless score #vo28 ca_ctx matches 0 run return 0
execute unless score #vo22 ca_ctx matches 0 run return 0
execute unless score #vo33 ca_ctx matches 0 run return 0
execute unless score #vo34 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo34 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo40 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo41 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
