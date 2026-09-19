# 白队提交完成后立即公开提示，并依次进行黑队拦截、白队解密。
tellraw @a[tag=dc.player] [{text:'[白队提示] ',color:'white'},{nbt:'white.1',storage:'decrypto:round',interpret:true,color:'aqua'},{text:'　/　',color:'gray'},{nbt:'white.2',storage:'decrypto:round',interpret:true,color:'aqua'},{text:'　/　',color:'gray'},{nbt:'white.3',storage:'decrypto:round',interpret:true,color:'aqua'}]
tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'请讨论并填写白队密码。第一轮不进行拦截。',color:'yellow'}]
execute if score @s dc_round matches 1 run scoreboard players set @s dc_state 6
execute unless score @s dc_round matches 1 run scoreboard players set @s dc_state 5
function decrypto:round/open_guess
