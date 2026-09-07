scoreboard players add @s dc_clue 1
execute if score @s dc_state matches 2 if score @s dc_clue matches 1 run data modify storage decrypto:round white.1 set from storage decrypto:input name
execute if score @s dc_state matches 2 if score @s dc_clue matches 2 run data modify storage decrypto:round white.2 set from storage decrypto:input name
execute if score @s dc_state matches 2 if score @s dc_clue matches 3 run data modify storage decrypto:round white.3 set from storage decrypto:input name
execute if score @s dc_state matches 4 if score @s dc_clue matches 1 run data modify storage decrypto:round black.1 set from storage decrypto:input name
execute if score @s dc_state matches 4 if score @s dc_clue matches 2 run data modify storage decrypto:round black.2 set from storage decrypto:input name
execute if score @s dc_state matches 4 if score @s dc_clue matches 3 run data modify storage decrypto:round black.3 set from storage decrypto:input name
execute if score @s dc_clue matches 3 if score @s dc_state matches 2 if score @s dc_mode matches 4 run function decrypto:round/reveal_white
execute if score @s dc_clue matches 3 if score @s dc_state matches 2 if score @s dc_mode matches 3 run function decrypto:round/reveal_notes
execute if score @s dc_clue matches 3 if score @s dc_state matches 4 run function decrypto:round/reveal_black
