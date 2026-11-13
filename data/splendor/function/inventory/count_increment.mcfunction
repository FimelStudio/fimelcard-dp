scoreboard players set #inv_needed sp_ctx 0
$execute store result score #inv_needed sp_ctx run data get storage splendor:inventory counts.c$(canonical)
scoreboard players add #inv_needed sp_ctx 1
$execute store result storage splendor:inventory counts.c$(canonical) int 1 run scoreboard players get #inv_needed sp_ctx
