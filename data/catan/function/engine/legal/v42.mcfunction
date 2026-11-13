scoreboard players set #valid ca_ctx 0
execute unless score #vo42 ca_ctx matches 0 run return 0
execute unless score #vo37 ca_ctx matches 0 run return 0
execute unless score #vo46 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo53 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo61 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
