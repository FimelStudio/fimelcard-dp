$execute store result score #inventory_count ca_ctx run clear @s minecraft:$(item)[minecraft:custom_data~{catan:{resource:1b}}] 0
$execute if score #inventory_count ca_ctx matches $(count) run return 0
$clear @s minecraft:$(item)[minecraft:custom_data~{catan:{resource:1b}}]
execute if score #res ca_ctx matches 1..64 run function catan:direct/give_resource with storage catan:direct
