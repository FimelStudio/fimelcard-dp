function decrypto:player/audience
tellraw @a[tag=dc.audience] {text:"[谍报风云] 解密与拦截时间到，结算已提交的答案。",color:"yellow"}
execute unless data entity @s data.decrypto.sync.answers.p6 run data modify entity @s data.decrypto.sync.answers.p6 set value [0,0,0]
execute if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.answers.p8 run data modify entity @s data.decrypto.sync.answers.p8 set value [0,0,0]
execute if score @s dc_round matches 2.. unless data entity @s data.decrypto.sync.answers.p5 run data modify entity @s data.decrypto.sync.answers.p5 set value [0,0,0]
execute if score @s dc_round matches 2.. if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.answers.p7 run data modify entity @s data.decrypto.sync.answers.p7 set value [0,0,0]
function decrypto:sync/resolve
