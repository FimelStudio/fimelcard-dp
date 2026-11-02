execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 1..4 run return run function catan:engine/error {id:5}
execute if score #target ca_ctx > #n ca_ctx run return run function catan:engine/error {id:5}
execute if score #target ca_ctx = #actor ca_ctx run return run function catan:engine/error {id:5}
execute unless score #actor ca_ctx = #turn ca_ctx unless score #target ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
function catan:engine/load_other with storage catan:engine request
function catan:engine/read_offer
scoreboard players set #offer_total ca_ctx 0
scoreboard players set #want_total ca_ctx 0
execute unless score #offer0 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute unless score #want0 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute if score #offer0 ca_ctx matches 1.. if score #want0 ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute if score #offer0 ca_ctx > #r0 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer0 ca_ctx
scoreboard players operation #want_total ca_ctx += #want0 ca_ctx
execute unless score #offer1 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute unless score #want1 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute if score #offer1 ca_ctx matches 1.. if score #want1 ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute if score #offer1 ca_ctx > #r1 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer1 ca_ctx
scoreboard players operation #want_total ca_ctx += #want1 ca_ctx
execute unless score #offer2 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute unless score #want2 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute if score #offer2 ca_ctx matches 1.. if score #want2 ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute if score #offer2 ca_ctx > #r2 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer2 ca_ctx
scoreboard players operation #want_total ca_ctx += #want2 ca_ctx
execute unless score #offer3 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute unless score #want3 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute if score #offer3 ca_ctx matches 1.. if score #want3 ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute if score #offer3 ca_ctx > #r3 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer3 ca_ctx
scoreboard players operation #want_total ca_ctx += #want3 ca_ctx
execute unless score #offer4 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute unless score #want4 ca_ctx matches 0..19 run return run function catan:engine/error {id:8}
execute if score #offer4 ca_ctx matches 1.. if score #want4 ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute if score #offer4 ca_ctx > #r4 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #offer_total ca_ctx += #offer4 ca_ctx
scoreboard players operation #want_total ca_ctx += #want4 ca_ctx
execute unless score #offer_total ca_ctx matches 1.. run return run function catan:engine/error {id:8}
execute unless score #want_total ca_ctx matches 1.. run return run function catan:engine/error {id:8}
data modify storage catan:engine state.trade set value {id:0,from:0,to:0,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
scoreboard players operation #trade_id ca_ctx = #epoch ca_ctx
scoreboard players add #trade_id ca_ctx 1
execute store result storage catan:engine state.trade.id int 1 run scoreboard players get #trade_id ca_ctx
execute store result storage catan:engine state.trade.from int 1 run scoreboard players get #actor ca_ctx
execute store result storage catan:engine state.trade.to int 1 run scoreboard players get #target ca_ctx
data modify storage catan:engine state.last.from set from storage catan:engine state.trade.from
data modify storage catan:engine state.last.to set from storage catan:engine state.trade.to
execute store result storage catan:engine state.trade.offer[0] int 1 run scoreboard players get #offer0 ca_ctx
execute store result storage catan:engine state.trade.want[0] int 1 run scoreboard players get #want0 ca_ctx
execute store result storage catan:engine state.trade.offer[1] int 1 run scoreboard players get #offer1 ca_ctx
execute store result storage catan:engine state.trade.want[1] int 1 run scoreboard players get #want1 ca_ctx
execute store result storage catan:engine state.trade.offer[2] int 1 run scoreboard players get #offer2 ca_ctx
execute store result storage catan:engine state.trade.want[2] int 1 run scoreboard players get #want2 ca_ctx
execute store result storage catan:engine state.trade.offer[3] int 1 run scoreboard players get #offer3 ca_ctx
execute store result storage catan:engine state.trade.want[3] int 1 run scoreboard players get #want3 ca_ctx
execute store result storage catan:engine state.trade.offer[4] int 1 run scoreboard players get #offer4 ca_ctx
execute store result storage catan:engine state.trade.want[4] int 1 run scoreboard players get #want4 ca_ctx
scoreboard players set #ok ca_ctx 1
