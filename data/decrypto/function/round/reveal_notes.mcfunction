# 三人合作模式：合作队提示锁定后进入己方解码。
tellraw @a[tag=dc.player] [{text:'[合作队提示] ',color:'white'},{nbt:'white.1',storage:'decrypto:round',interpret:true,color:'aqua'},{text:'　/　',color:'gray'},{nbt:'white.2',storage:'decrypto:round',interpret:true,color:'aqua'},{text:'　/　',color:'gray'},{nbt:'white.3',storage:'decrypto:round',interpret:true,color:'aqua'}]
tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'合作队提示已锁定，请讨论并准备解码。',color:'yellow'}]
execute if score @s dc_round matches 1 run scoreboard players set @s dc_state 6
execute unless score @s dc_round matches 1 run scoreboard players set @s dc_state 5
function decrypto:round/open_guess
