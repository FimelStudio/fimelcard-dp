execute store result storage splendor:affordable slot int 1 run scoreboard players get @s sp_vid
function splendor:visual/affordable/resolve with storage splendor:affordable
function splendor:visual/affordable/check
execute if score #aff_ok sp_ctx matches 1 run function splendor:visual/affordable/emit
