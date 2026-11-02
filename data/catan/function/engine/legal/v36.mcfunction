scoreboard players set #valid ca_ctx 0
execute unless score #vo36 ca_ctx matches 0 run return 0
execute unless score #vo30 ca_ctx matches 0 run return 0
execute unless score #vo31 ca_ctx matches 0 run return 0
execute unless score #vo41 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo45 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo46 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo52 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
