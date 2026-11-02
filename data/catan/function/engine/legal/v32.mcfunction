scoreboard players set #valid ca_ctx 0
execute unless score #vo32 ca_ctx matches 0 run return 0
execute unless score #vo26 ca_ctx matches 0 run return 0
execute unless score #vo37 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo38 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo48 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
