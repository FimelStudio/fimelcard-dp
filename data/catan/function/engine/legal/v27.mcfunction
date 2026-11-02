scoreboard players set #valid ca_ctx 0
execute unless score #vo27 ca_ctx matches 0 run return 0
execute unless score #vo21 ca_ctx matches 0 run return 0
execute unless score #vo33 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo33 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo39 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
