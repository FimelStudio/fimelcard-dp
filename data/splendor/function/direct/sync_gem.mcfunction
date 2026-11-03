$execute store result score #inventory_count sp_ctx run clear @s minecraft:$(item)[minecraft:custom_data~{splendor:{gem:1b}}] 0
$execute if score #inventory_count sp_ctx matches $(count) run return 0
$clear @s minecraft:$(item)[minecraft:custom_data~{splendor:{gem:1b}}]
execute if score #gem_count sp_ctx matches 1..64 run function splendor:direct/give_gem with storage splendor:direct
