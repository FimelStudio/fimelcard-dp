execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..4 run return run function catan:engine/error {id:5}
execute unless score #a ca_ctx matches 0..4 run return run function catan:engine/error {id:5}
execute if score #target ca_ctx = #a ca_ctx run return run function catan:engine/error {id:8}
execute if score #b ca_ctx matches -1 run scoreboard players set #b ca_ctx 1
execute unless score #b ca_ctx matches 1..19 run return run function catan:engine/error {id:8}
scoreboard players set #ratio ca_ctx 4
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[0]
execute if score #vo0 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo3 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[1]
execute if score #vo11 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo16 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[2]
execute if score #vo27 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo33 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[3]
execute if score #vo47 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo51 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[4]
execute if score #vo49 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo52 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[5]
execute if score #vo46 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo50 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[6]
execute if score #vo26 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo32 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[7]
execute if score #vo10 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo15 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[8]
execute if score #vo2 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
execute if score #vo5 ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio
function catan:engine/trade/bank_exchange with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:6}
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_bank
scoreboard players set #ok ca_ctx 1
