scoreboard players set #valid ca_ctx 0
execute unless score #vo40 ca_ctx matches 0 run return 0
execute unless score #vo35 ca_ctx matches 0 run return 0
execute unless score #vo44 ca_ctx matches 0 run return 0
execute unless score #vo45 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo51 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo57 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo58 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
