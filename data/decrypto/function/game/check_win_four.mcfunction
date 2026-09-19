execute if score @s dc_wi matches 2.. run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'白队获得第2枚拦截指示物，白队获胜！',color:'gold'}]
execute if score @s dc_wi matches 2.. run function decrypto:game/finish
execute if score @s dc_wi matches 2.. run return 1
execute if score @s dc_bi matches 2.. run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'黑队获得第2枚拦截指示物，黑队获胜！',color:'gold'}]
execute if score @s dc_bi matches 2.. run function decrypto:game/finish
execute if score @s dc_bi matches 2.. run return 1
execute if score @s dc_we matches 2.. run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'白队累计2次错误传讯，黑队获胜！',color:'gold'}]
execute if score @s dc_we matches 2.. run function decrypto:game/finish
execute if score @s dc_we matches 2.. run return 1
execute if score @s dc_be matches 2.. run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'黑队累计2次错误传讯，白队获胜！',color:'gold'}]
execute if score @s dc_be matches 2.. run function decrypto:game/finish
execute if score @s dc_be matches 2.. run return 1
return 0
