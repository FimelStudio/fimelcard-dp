execute if score #sync_team dc_ctx matches 1 if score #decode dc_ctx matches 1 run data modify entity @s data.decrypto.sync.answers.p6 set from storage decrypto:sync d_answer
execute if score #sync_team dc_ctx matches 1 if score #intercept dc_ctx matches 1 run data modify entity @s data.decrypto.sync.answers.p7 set from storage decrypto:sync i_answer
execute if score #sync_team dc_ctx matches 2 if score #decode dc_ctx matches 1 run data modify entity @s data.decrypto.sync.answers.p8 set from storage decrypto:sync d_answer
execute if score #sync_team dc_ctx matches 2 if score #intercept dc_ctx matches 1 run data modify entity @s data.decrypto.sync.answers.p5 set from storage decrypto:sync i_answer
function decrypto:player/audience
tellraw @a[tag=dc.audience] [{selector:"@a[tag=dc.sync_submitter]",color:"gold"},{text:" 已提交本轮答案。",color:"green"}]
execute unless data entity @s data.decrypto.sync.answers.p6 run return 0
execute unless data entity @s data.decrypto.sync.answers.p8 run return 0
execute unless score @s dc_round matches 1 unless data entity @s data.decrypto.sync.answers.p5 run return 0
execute unless score @s dc_round matches 1 unless data entity @s data.decrypto.sync.answers.p7 run return 0
function decrypto:sync/resolve
