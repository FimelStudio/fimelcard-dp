execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
function catan:engine/trade/read
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:11}
execute unless score #actor ca_ctx = #trade_to ca_ctx run return run function catan:engine/error {id:11}
execute store result storage catan:engine request.target int 1 run scoreboard players get #trade_from ca_ctx
function catan:engine/load_other with storage catan:engine request
execute if score #offer0 ca_ctx > #o0 ca_ctx run return run function catan:engine/error {id:6}
execute if score #want0 ca_ctx > #r0 ca_ctx run return run function catan:engine/error {id:6}
execute if score #offer1 ca_ctx > #o1 ca_ctx run return run function catan:engine/error {id:6}
execute if score #want1 ca_ctx > #r1 ca_ctx run return run function catan:engine/error {id:6}
execute if score #offer2 ca_ctx > #o2 ca_ctx run return run function catan:engine/error {id:6}
execute if score #want2 ca_ctx > #r2 ca_ctx run return run function catan:engine/error {id:6}
execute if score #offer3 ca_ctx > #o3 ca_ctx run return run function catan:engine/error {id:6}
execute if score #want3 ca_ctx > #r3 ca_ctx run return run function catan:engine/error {id:6}
execute if score #offer4 ca_ctx > #o4 ca_ctx run return run function catan:engine/error {id:6}
execute if score #want4 ca_ctx > #r4 ca_ctx run return run function catan:engine/error {id:6}
scoreboard players operation #r0 ca_ctx += #offer0 ca_ctx
scoreboard players operation #r0 ca_ctx -= #want0 ca_ctx
scoreboard players operation #o0 ca_ctx += #want0 ca_ctx
scoreboard players operation #o0 ca_ctx -= #offer0 ca_ctx
scoreboard players operation #r1 ca_ctx += #offer1 ca_ctx
scoreboard players operation #r1 ca_ctx -= #want1 ca_ctx
scoreboard players operation #o1 ca_ctx += #want1 ca_ctx
scoreboard players operation #o1 ca_ctx -= #offer1 ca_ctx
scoreboard players operation #r2 ca_ctx += #offer2 ca_ctx
scoreboard players operation #r2 ca_ctx -= #want2 ca_ctx
scoreboard players operation #o2 ca_ctx += #want2 ca_ctx
scoreboard players operation #o2 ca_ctx -= #offer2 ca_ctx
scoreboard players operation #r3 ca_ctx += #offer3 ca_ctx
scoreboard players operation #r3 ca_ctx -= #want3 ca_ctx
scoreboard players operation #o3 ca_ctx += #want3 ca_ctx
scoreboard players operation #o3 ca_ctx -= #offer3 ca_ctx
scoreboard players operation #r4 ca_ctx += #offer4 ca_ctx
scoreboard players operation #r4 ca_ctx -= #want4 ca_ctx
scoreboard players operation #o4 ca_ctx += #want4 ca_ctx
scoreboard players operation #o4 ca_ctx -= #offer4 ca_ctx
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_other with storage catan:engine request
data remove storage catan:engine state.trade
scoreboard players set #ok ca_ctx 1
