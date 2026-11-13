execute unless score #phase sp_ctx matches 2 run return run function splendor:engine/error {id:5}
scoreboard players set #total sp_ctx 0
scoreboard players set #held sp_ctx 0
execute if score #take0 sp_ctx > #token0 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take0 sp_ctx
scoreboard players operation #held sp_ctx += #token0 sp_ctx
execute if score #take1 sp_ctx > #token1 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take1 sp_ctx
scoreboard players operation #held sp_ctx += #token1 sp_ctx
execute if score #take2 sp_ctx > #token2 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take2 sp_ctx
scoreboard players operation #held sp_ctx += #token2 sp_ctx
execute if score #take3 sp_ctx > #token3 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take3 sp_ctx
scoreboard players operation #held sp_ctx += #token3 sp_ctx
execute if score #take4 sp_ctx > #token4 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take4 sp_ctx
scoreboard players operation #held sp_ctx += #token4 sp_ctx
execute if score #take5 sp_ctx > #token5 sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #total sp_ctx += #take5 sp_ctx
scoreboard players operation #held sp_ctx += #token5 sp_ctx
scoreboard players remove #held sp_ctx 10
execute unless score #total sp_ctx = #held sp_ctx run return run function splendor:engine/error {id:7}
scoreboard players operation #token0 sp_ctx -= #take0 sp_ctx
scoreboard players operation #bank0 sp_ctx += #take0 sp_ctx
scoreboard players operation #token1 sp_ctx -= #take1 sp_ctx
scoreboard players operation #bank1 sp_ctx += #take1 sp_ctx
scoreboard players operation #token2 sp_ctx -= #take2 sp_ctx
scoreboard players operation #bank2 sp_ctx += #take2 sp_ctx
scoreboard players operation #token3 sp_ctx -= #take3 sp_ctx
scoreboard players operation #bank3 sp_ctx += #take3 sp_ctx
scoreboard players operation #token4 sp_ctx -= #take4 sp_ctx
scoreboard players operation #bank4 sp_ctx += #take4 sp_ctx
scoreboard players operation #token5 sp_ctx -= #take5 sp_ctx
scoreboard players operation #bank5 sp_ctx += #take5 sp_ctx
data modify storage splendor:engine state.last.take set from storage splendor:engine request.take
function splendor:engine/save_actor with storage splendor:engine request
function splendor:engine/save_bank
data modify storage splendor:engine state.discard_due set value 0
function splendor:engine/noble/check
scoreboard players set #ok sp_ctx 1
