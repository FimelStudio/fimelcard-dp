scoreboard players set #held sp_ctx 0
scoreboard players operation #held sp_ctx += #token0 sp_ctx
scoreboard players operation #held sp_ctx += #token1 sp_ctx
scoreboard players operation #held sp_ctx += #token2 sp_ctx
scoreboard players operation #held sp_ctx += #token3 sp_ctx
scoreboard players operation #held sp_ctx += #token4 sp_ctx
scoreboard players operation #held sp_ctx += #token5 sp_ctx
execute if score #held sp_ctx matches 11.. run data modify storage splendor:engine state.phase set value 2
execute if score #held sp_ctx matches 11.. run scoreboard players remove #held sp_ctx 10
execute if data storage splendor:engine state{phase:2} store result storage splendor:engine state.discard_due int 1 run scoreboard players get #held sp_ctx
execute if data storage splendor:engine state{phase:2} run return 1
function splendor:engine/noble/check
