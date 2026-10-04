function decrypto:player/audience
scoreboard players operation #threat dc_ctx = @s dc_bi
scoreboard players operation #threat dc_ctx += @s dc_we
execute if score #threat dc_ctx matches 2.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'截密者累计获得2次有效成果，截密者获胜！',color:'gold'}]
execute if score #threat dc_ctx matches 2.. run function decrypto:game/finish
execute if score #threat dc_ctx matches 2.. run return 1
return 0
