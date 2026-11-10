scoreboard players set @s dc_state 5
function decrypto:player/audience
scoreboard players set @a[tag=dc.audience] dc_sd 0
function decrypto:sync/load_clues
tellraw @a[tag=dc.audience] [{text:"白队提示：",color:"white"},{nbt:"data.decrypto.sync.white.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
tellraw @a[tag=dc.audience] [{text:"黑队提示：",color:"gray"},{nbt:"data.decrypto.sync.black.clues[]",entity:"@s",interpret:true,separator:{text:" / "}}]
tag @e[tag=dc.sync_controller] remove dc.sync_controller
tag @s add dc.sync_controller
execute as @a[tag=dc.audience] run function decrypto:sync/give_guess
tellraw @a[tag=dc.audience] {text:"[谍报风云] 同时进行拦截与解密；按Q使用提交密码染料。全部负责输入的玩家提交后统一公布结果。",color:"yellow"}
