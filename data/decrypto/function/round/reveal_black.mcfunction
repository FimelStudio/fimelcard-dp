# 白队密码已结算；现在公开黑队提示并处理黑队密码。
tellraw @a[tag=dc.player] [{text:'[黑队提示] ',color:'dark_gray'},{nbt:'black.1',storage:'decrypto:round',interpret:true,color:'light_purple'},{text:'　/　',color:'gray'},{nbt:'black.2',storage:'decrypto:round',interpret:true,color:'light_purple'},{text:'　/　',color:'gray'},{nbt:'black.3',storage:'decrypto:round',interpret:true,color:'light_purple'}]
tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'请讨论并填写黑队密码。第一轮不进行拦截。',color:'yellow'}]
execute if score @s dc_round matches 1 run scoreboard players set @s dc_state 8
execute unless score @s dc_round matches 1 run scoreboard players set @s dc_state 7
function decrypto:round/open_guess
