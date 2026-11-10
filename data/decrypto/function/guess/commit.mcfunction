execute if score @s dc_sync matches 1 run return run function decrypto:sync/store_answers with storage decrypto:guess
execute store result score @s dc_guess1 run data get storage decrypto:guess answer[0]
execute store result score @s dc_guess2 run data get storage decrypto:guess answer[1]
execute store result score @s dc_guess3 run data get storage decrypto:guess answer[2]
function decrypto:round/resolve_guess
