$execute store result score #have ca_ctx run clear @s *[minecraft:custom_data~{catan:{resource:1b,id:$(id)}}] 0
execute if score #have ca_ctx = #wanted ca_ctx run return 0
$clear @s *[minecraft:custom_data~{catan:{resource:1b,id:$(id)}}]
execute if score #wanted ca_ctx matches 1.. run function catan:direct/inventory_space
execute if score #wanted ca_ctx matches 1.. unless score #space ca_ctx matches 1 run return run function catan:direct/no_space
$data modify storage catan:direct card set value {id:$(id),name:"$(name)",model:"$(model)"}
data modify storage catan:direct card.count set from storage catan:direct count
data modify storage catan:direct card.table set from storage catan:direct table
execute if score #wanted ca_ctx matches 1.. run function catan:direct/resource_item with storage catan:direct card
