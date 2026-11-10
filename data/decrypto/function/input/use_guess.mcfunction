function decrypto:guess/bind
execute unless score #guess_phase dc_ctx matches 5..8 run return 0
tag @s add dc.sync_drop_owner
scoreboard players set #has_owned_drop dc_ctx 0
execute as @e[type=minecraft:item,tag=dc.guess_drop] run function decrypto:sync/own_drop
tag @s remove dc.sync_drop_owner
execute unless score #has_owned_drop dc_ctx matches 1 run return 0
function decrypto:input/give_guess
function decrypto:guess/open
