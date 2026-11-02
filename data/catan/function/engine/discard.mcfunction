execute unless score #phase ca_ctx matches 5 run return run function catan:engine/error {id:4}
execute unless score #discard_due ca_ctx matches 1.. run return run function catan:engine/error {id:11}
function catan:engine/read_offer
scoreboard players set #offer_total ca_ctx 0
execute if score #offer0 ca_ctx matches ..-1 run return run function catan:engine/error {id:8}
execute if score #offer0 ca_ctx > #r0 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer0 ca_ctx
execute if score #offer1 ca_ctx matches ..-1 run return run function catan:engine/error {id:8}
execute if score #offer1 ca_ctx > #r1 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer1 ca_ctx
execute if score #offer2 ca_ctx matches ..-1 run return run function catan:engine/error {id:8}
execute if score #offer2 ca_ctx > #r2 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer2 ca_ctx
execute if score #offer3 ca_ctx matches ..-1 run return run function catan:engine/error {id:8}
execute if score #offer3 ca_ctx > #r3 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer3 ca_ctx
execute if score #offer4 ca_ctx matches ..-1 run return run function catan:engine/error {id:8}
execute if score #offer4 ca_ctx > #r4 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer4 ca_ctx
execute unless score #offer_total ca_ctx = #discard_due ca_ctx run return run function catan:engine/error {id:8}
scoreboard players operation #r0 ca_ctx -= #offer0 ca_ctx
scoreboard players operation #bank0 ca_ctx += #offer0 ca_ctx
scoreboard players operation #r1 ca_ctx -= #offer1 ca_ctx
scoreboard players operation #bank1 ca_ctx += #offer1 ca_ctx
scoreboard players operation #r2 ca_ctx -= #offer2 ca_ctx
scoreboard players operation #bank2 ca_ctx += #offer2 ca_ctx
scoreboard players operation #r3 ca_ctx -= #offer3 ca_ctx
scoreboard players operation #bank3 ca_ctx += #offer3 ca_ctx
scoreboard players operation #r4 ca_ctx -= #offer4 ca_ctx
scoreboard players operation #bank4 ca_ctx += #offer4 ca_ctx
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_bank
function catan:engine/discard_done with storage catan:engine request
scoreboard players set #all_due ca_ctx 0
execute store result score #due ca_ctx run data get storage catan:engine state.p1.discard_due
scoreboard players operation #all_due ca_ctx += #due ca_ctx
execute store result score #due ca_ctx run data get storage catan:engine state.p2.discard_due
scoreboard players operation #all_due ca_ctx += #due ca_ctx
execute store result score #due ca_ctx run data get storage catan:engine state.p3.discard_due
scoreboard players operation #all_due ca_ctx += #due ca_ctx
execute store result score #due ca_ctx run data get storage catan:engine state.p4.discard_due
scoreboard players operation #all_due ca_ctx += #due ca_ctx
execute if score #all_due ca_ctx matches 0 run data modify storage catan:engine state.phase set value 6
scoreboard players set #ok ca_ctx 1
