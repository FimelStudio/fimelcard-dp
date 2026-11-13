scoreboard players set #card sp_ctx -1
scoreboard players set #tier sp_ctx 1
scoreboard players set #index sp_ctx -1
execute unless score #target sp_ctx matches 0..14 run return run function splendor:engine/error {id:8}
execute if score #target sp_ctx matches 0..11 run function splendor:engine/resolve_market with storage splendor:engine request
execute if score #target sp_ctx matches 12..14 run function splendor:engine/resolve_reserved
execute unless score #card sp_ctx matches 0..89 run return run function splendor:engine/error {id:8}
execute store result storage splendor:engine meta.card int 1 run scoreboard players get #card sp_ctx
function splendor:engine/load_card with storage splendor:engine meta
scoreboard players set #valid sp_ctx 1
