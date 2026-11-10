execute if score @s dc_sd matches 1 run return 0
function decrypto:sync/duties
execute if score #duties dc_ctx matches 1.. run function decrypto:input/give_guess
