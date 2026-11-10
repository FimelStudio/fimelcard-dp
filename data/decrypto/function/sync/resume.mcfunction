function decrypto:player/audience
tag @e[tag=dc.sync_controller] remove dc.sync_controller
tag @s add dc.sync_controller
scoreboard players operation #prompt_input dc_ctx = @s dc_input
execute if score @s dc_state matches 2 unless data entity @s data.decrypto.sync.white.clues as @a[tag=dc.audience,scores={dc_team=1,dc_encoder=1}] run function decrypto:sync/restore_prompt
execute if score @s dc_state matches 2 unless data entity @s data.decrypto.sync.black.clues as @a[tag=dc.audience,scores={dc_team=2,dc_encoder=1}] run function decrypto:sync/restore_prompt
execute if score @s dc_state matches 5 as @a[tag=dc.audience] run function decrypto:sync/give_guess
function decrypto:title/update_all
