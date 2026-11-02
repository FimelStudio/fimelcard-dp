scoreboard players set #valid ca_ctx 0
$execute if score #vo$(target) ca_ctx = #actor ca_ctx if score #vl$(target) ca_ctx matches 1 run scoreboard players set #valid ca_ctx 1
