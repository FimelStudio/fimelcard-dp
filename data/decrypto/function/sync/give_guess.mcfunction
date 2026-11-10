function decrypto:guess/bind
execute unless score #guess_phase dc_ctx matches 5..8 run return run clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:"guess"}}]
function decrypto:input/give_guess
