execute unless score @s dc_state matches 2 run return 0
execute if score #sync_team dc_ctx matches 1 if data entity @s data.decrypto.sync.white.clues run return 0
execute if score #sync_team dc_ctx matches 2 if data entity @s data.decrypto.sync.black.clues run return 0
execute if score #sync_team dc_ctx matches 1 run data modify entity @s data.decrypto.sync.white.clues set from storage decrypto:input clues
execute if score #sync_team dc_ctx matches 2 run data modify entity @s data.decrypto.sync.black.clues set from storage decrypto:input clues
function decrypto:player/audience
tag @a[tag=dc.sync_submitter] remove dc.sync_submitter
execute as @a[tag=dc.audience,scores={dc_encoder=1}] if score @s dc_team = #sync_team dc_ctx run tag @s add dc.sync_submitter
tellraw @a[tag=dc.audience] [{text:"[谍报风云] ",color:"aqua"},{selector:"@a[tag=dc.sync_submitter]",color:"gold"},{text:" 已提交加密提示。",color:"green"}]
execute if score @s dc_mode matches 3 if data entity @s data.decrypto.sync.white.clues run return run function decrypto:sync/open_guesses
execute if data entity @s data.decrypto.sync.white.clues if data entity @s data.decrypto.sync.black.clues run return run function decrypto:sync/open_guesses
function decrypto:hint/update
