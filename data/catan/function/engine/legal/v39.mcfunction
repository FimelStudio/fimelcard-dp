scoreboard players set #valid ca_ctx 0
execute unless score #vo39 ca_ctx matches 0 run return 0
execute unless score #vo34 ca_ctx matches 0 run return 0
execute unless score #vo43 ca_ctx matches 0 run return 0
execute unless score #vo44 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo50 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo55 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo56 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
