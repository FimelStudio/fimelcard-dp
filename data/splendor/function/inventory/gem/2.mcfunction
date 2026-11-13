scoreboard players set #inv_count sp_ctx 0
$execute store result score #inv_count sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:0,color:2}}] 0
scoreboard players set #inv_slot sp_ctx -1
$execute if items entity @s hotbar.2 *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:0,color:2}}] store result score #inv_slot sp_ctx run data get entity @s Inventory[{Slot:2b}].count
$execute if score #inv_count sp_ctx matches $(count) if score #inv_slot sp_ctx matches $(count) run return 1
$clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:0,color:2}}]
$execute if predicate {condition:"minecraft:value_check",value:$(count),range:0} run return 1
execute store result score #inv_room sp_ctx run function splendor:inventory/free_hotbar/2
execute unless score #inv_room sp_ctx matches 1 run return 0
function splendor:inventory/gem/place_2 with storage splendor:inventory ctx
