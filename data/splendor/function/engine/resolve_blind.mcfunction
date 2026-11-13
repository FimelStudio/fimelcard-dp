scoreboard players operation #tier sp_ctx = #index sp_ctx
scoreboard players add #tier sp_ctx 1
execute store result storage splendor:engine request.tier int 1 run scoreboard players get #tier sp_ctx
function splendor:engine/resolve_deck with storage splendor:engine request
