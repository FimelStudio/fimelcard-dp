scoreboard players set @s dc_state 5
function decrypto:player/audience
function decrypto:sync/load_clues
tellraw @a[tag=dc.audience] [{text:"白队提示：",color:"white"},{nbt:"data.decrypto.sync.white.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
tellraw @a[tag=dc.audience] [{text:"黑队提示：",color:"gray"},{nbt:"data.decrypto.sync.black.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
tag @e[tag=dc.sync_controller] remove dc.sync_controller
tag @s add dc.sync_controller
execute as @a[tag=dc.audience] run function decrypto:sync/give_guess
execute if score @s dc_round matches 1 run tellraw @a[tag=dc.audience] {text:"[谍报风云] 首轮只解密。解密者按Q使用紫色染料提交，两队交齐后统一公布结果。",color:"yellow"}
execute unless score @s dc_round matches 1 run tellraw @a[tag=dc.audience] {text:"[谍报风云] 解密和拦截同时开始。负责的玩家按Q使用紫色染料提交，所有答案交齐后统一公布结果。",color:"yellow"}
