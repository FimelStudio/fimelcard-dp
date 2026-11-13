execute store result storage splendor:engine request.tier int 1 run scoreboard players get #tier sp_ctx
execute if score #target sp_ctx matches 0..11 run function splendor:engine/remove_market with storage splendor:engine request
execute if score #target sp_ctx matches 12..14 if score #code sp_ctx matches 2 run function splendor:engine/remove_blind with storage splendor:engine request
execute if score #target sp_ctx matches 12..14 if score #code sp_ctx matches 3 run function splendor:engine/remove_reserve with storage splendor:engine request
execute store result storage splendor:engine state.last.card int 1 run scoreboard players get #card sp_ctx
