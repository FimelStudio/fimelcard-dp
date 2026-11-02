scoreboard players set #valid ca_ctx 0
execute unless score #vo53 ca_ctx matches 0 run return 0
execute unless score #vo49 ca_ctx matches 0 run return 0
execute unless score #vo50 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo70 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo71 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
