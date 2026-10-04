function decrypto:player/can_input
execute if score #authorized dc_ctx matches 1 run tag @s add dc.guesser
