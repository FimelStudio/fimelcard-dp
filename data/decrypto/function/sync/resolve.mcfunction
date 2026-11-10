function decrypto:sync/load_clues
scoreboard players set @s dc_binter 0
scoreboard players set @s dc_winter 0
execute unless score @s dc_round matches 1 run function decrypto:sync/resolve_5
execute unless score @s dc_round matches 1 run function decrypto:sync/resolve_7
function decrypto:sync/resolve_6
function decrypto:sync/resolve_8
function decrypto:sync/check_win
execute if score @s dc_state matches 1..8 run function decrypto:round/next
