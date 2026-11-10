execute unless entity @e[tag=dc.sync_controller,scores={dc_state=5},limit=1] run return 0
execute if score @s dc_sd matches 1 run return 0
function decrypto:sync/duties
execute unless score #duties dc_ctx matches 1.. run return 0
tag @a[tag=dc.sync_drop_owner] remove dc.sync_drop_owner
tag @s add dc.sync_drop_owner
scoreboard players set #has_owned_drop dc_ctx 0
execute as @e[tag=dc.guess_drop] run function decrypto:sync/own_drop
tag @s remove dc.sync_drop_owner
execute unless score #has_owned_drop dc_ctx matches 1 run return 0
function decrypto:input/give_guess
function decrypto:sync/guess_dialog
