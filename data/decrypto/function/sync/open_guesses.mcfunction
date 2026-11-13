scoreboard players set @s dc_state 5
function decrypto:player/audience
execute unless data entity @s data.decrypto.sync.white.clues unless data entity @s data.decrypto.sync.black.clues run return run function decrypto:sync/resolve
function decrypto:sync/load_clues
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.audience] [{text:"合作队提示：",color:"red"},{nbt:"data.decrypto.sync.white.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
execute if score @s dc_mode matches 4 if data entity @s data.decrypto.sync.white.clues run tellraw @a[tag=dc.audience] [{text:"红队提示：",color:"red"},{nbt:"data.decrypto.sync.white.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
execute if data entity @s data.decrypto.sync.black.clues run tellraw @a[tag=dc.audience] [{text:"蓝队提示：",color:"blue"},{nbt:"data.decrypto.sync.black.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
tag @e[tag=dc.sync_controller] remove dc.sync_controller
tag @s add dc.sync_controller
execute as @a[tag=dc.audience] run function decrypto:sync/give_guess
execute if score @s dc_round matches 1 run tellraw @a[tag=dc.audience] {text:"[谍报风云] 首轮只解密。解密者按Q使用紫色染料提交，答案交齐后统一公布结果。",color:"yellow"}
execute if score @s dc_round matches 2.. run tellraw @a[tag=dc.audience] {text:"[谍报风云] 已公开的密码提示可同时解密和拦截。负责的玩家按Q使用紫色染料提交，答案交齐后统一公布结果。",color:"yellow"}
function decrypto:timer/start {limit:"dc_guess_limit"}
function decrypto:hint/update
function decrypto:title/update_all
