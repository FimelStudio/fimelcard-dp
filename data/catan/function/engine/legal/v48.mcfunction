scoreboard players set #valid ca_ctx 0
execute unless score #vo48 ca_ctx matches 0 run return 0
execute unless score #vo44 ca_ctx matches 0 run return 0
execute unless score #vo51 ca_ctx matches 0 run return 0
execute unless score #vo52 ca_ctx matches 0 run return 0
execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1
execute if score #eo63 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo67 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
execute if score #eo68 ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1
