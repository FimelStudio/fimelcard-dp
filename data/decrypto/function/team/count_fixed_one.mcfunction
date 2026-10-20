function decrypto:team/fixed_side
execute if score #fixed_side dc_ctx matches 1 run scoreboard players add #fixed_white dc_ctx 1
execute if score #fixed_side dc_ctx matches 2 run scoreboard players add #fixed_black dc_ctx 1
