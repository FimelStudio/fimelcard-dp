scoreboard players set @s dc_timer 0
scoreboard players set @s dc_seconds 0
function decrypto:player/audience
clear @a[tag=dc.audience] minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'timeout'}}]
execute as @a[tag=dc.audience,scores={dc_gserial=1..}] run dialog clear @s
scoreboard players reset @a[tag=dc.audience] dc_gserial
function decrypto:input/clear_guess
function decrypto:sync/load_clues
scoreboard players set @s dc_binter 0
scoreboard players set @s dc_winter 0
execute if score @s dc_round matches 2.. unless data entity @s data.decrypto.sync.white.timed_out run function decrypto:sync/resolve_5
execute if score @s dc_round matches 2.. if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.black.timed_out run function decrypto:sync/resolve_7
execute unless data entity @s data.decrypto.sync.white.timed_out run function decrypto:sync/resolve_6
execute if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.black.timed_out run function decrypto:sync/resolve_8
function decrypto:sync/check_win
execute if score @s dc_state matches 1..8 run function decrypto:round/next
