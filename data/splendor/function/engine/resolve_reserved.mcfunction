scoreboard players operation #index sp_ctx = #target sp_ctx
scoreboard players remove #index sp_ctx 12
execute store result storage splendor:engine request.index int 1 run scoreboard players get #index sp_ctx
execute if score #code sp_ctx matches 2 run function splendor:engine/resolve_blind
execute if score #code sp_ctx matches 3 run function splendor:engine/resolve_reserve_card with storage splendor:engine request
