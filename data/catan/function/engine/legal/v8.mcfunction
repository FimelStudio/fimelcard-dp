scoreboard players set #valid ca_ctx 0
execute unless score #vo8 ca_ctx matches 0 run return 0
execute unless score #vo4 ca_ctx matches 0 run return 0
execute unless score #vo12 ca_ctx matches 0 run return 0
execute unless score #vo13 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo7 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo12 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo13 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
