$data modify entity @s data.decrypto.sync.answers.p$(phase) set from storage decrypto:guess answer
function decrypto:player/audience
tellraw @a[tag=dc.audience] [{selector:"@a[tag=dc.sync_submitter]",color:"gold"},{text:" 已提交一组答案。",color:"green"}]
execute unless data entity @s data.decrypto.sync.answers.p6 run return 0
execute unless data entity @s data.decrypto.sync.answers.p8 run return 0
execute unless score @s dc_round matches 1 unless data entity @s data.decrypto.sync.answers.p5 run return 0
execute unless score @s dc_round matches 1 unless data entity @s data.decrypto.sync.answers.p7 run return 0
function decrypto:sync/resolve
