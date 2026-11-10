$execute store result score #bank_stock ca_ctx run data get storage catan:ui bank[$(receive)]
execute unless score #bank_stock ca_ctx matches 1.. run scoreboard players set #direct_ready ca_ctx 0
execute unless score #direct_ready ca_ctx matches 1 run function catan:direct/bank_empty with storage catan:direct
