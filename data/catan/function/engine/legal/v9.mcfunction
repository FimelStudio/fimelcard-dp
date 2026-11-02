scoreboard players set #valid ca_ctx 0
execute unless score #vo9 ca_ctx matches 0 run return 0
execute unless score #vo5 ca_ctx matches 0 run return 0
execute unless score #vo13 ca_ctx matches 0 run return 0
execute unless score #vo14 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo8 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo14 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo15 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
