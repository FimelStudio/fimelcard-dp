$data modify storage catan:direct ratio set from storage catan:ui ratio$(pay)
$data modify storage catan:direct have set from storage catan:ui hand.resources[$(pay)]
execute store result score #bank_have ca_ctx run data get storage catan:direct have
execute store result score #bank_ratio ca_ctx run data get storage catan:direct ratio
execute if score #bank_have ca_ctx < #bank_ratio ca_ctx run scoreboard players set #direct_ready ca_ctx 0
execute unless score #direct_ready ca_ctx matches 1 run function catan:direct/bank_short with storage catan:direct
