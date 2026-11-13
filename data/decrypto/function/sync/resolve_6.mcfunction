scoreboard players set @s dc_state 6
execute store result score @s dc_guess1 run data get entity @s data.decrypto.sync.answers.p6[0]
execute store result score @s dc_guess2 run data get entity @s data.decrypto.sync.answers.p6[1]
execute store result score @s dc_guess3 run data get entity @s data.decrypto.sync.answers.p6[2]
function decrypto:round/resolve_guess
