function decrypto:player/audience
execute if score @s dc_wi matches 2.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'红队获得第2枚拦截指示物，红队获胜！',color:'gold'}]
execute if score @s dc_wi matches 2.. run function decrypto:game/finish
execute if score @s dc_wi matches 2.. run return 1
execute if score @s dc_bi matches 2.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'蓝队获得第2枚拦截指示物，蓝队获胜！',color:'gold'}]
execute if score @s dc_bi matches 2.. run function decrypto:game/finish
execute if score @s dc_bi matches 2.. run return 1
execute if score @s dc_we matches 2.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'红队累计2次错误传讯，蓝队获胜！',color:'gold'}]
execute if score @s dc_we matches 2.. run function decrypto:game/finish
execute if score @s dc_we matches 2.. run return 1
execute if score @s dc_be matches 2.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'蓝队累计2次错误传讯，红队获胜！',color:'gold'}]
execute if score @s dc_be matches 2.. run function decrypto:game/finish
execute if score @s dc_be matches 2.. run return 1
return 0
