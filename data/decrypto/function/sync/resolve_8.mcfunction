scoreboard players set @s dc_state 8
execute store result score @s dc_guess1 run data get entity @s data.decrypto.sync.answers.p8[0]
execute store result score @s dc_guess2 run data get entity @s data.decrypto.sync.answers.p8[1]
execute store result score @s dc_guess3 run data get entity @s data.decrypto.sync.answers.p8[2]
function decrypto:round/resolve_guess
