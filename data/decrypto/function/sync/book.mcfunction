scoreboard players operation #sync_team dc_ctx = @a[tag=dc.submitter,limit=1] dc_team
execute if score #sync_team dc_ctx matches 1 if data entity @s data.decrypto.sync.white.clues run return 0
execute if score #sync_team dc_ctx matches 2 if data entity @s data.decrypto.sync.black.clues run return 0
function decrypto:input/accept_book
