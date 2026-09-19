data modify storage decrypto:wrap character set string storage decrypto:wrap remaining 0 1
data modify storage decrypto:wrap remaining set string storage decrypto:wrap remaining 1
execute unless data storage decrypto:wrap {character:"\n"} unless data storage decrypto:wrap {character:"\r"} run function decrypto:title/wrap/character
execute if data storage decrypto:wrap {character:"\n"} if score #columns dc_ctx matches 1.. run function decrypto:title/wrap/flush
execute if score #columns dc_ctx matches 36.. run function decrypto:title/wrap/flush
execute unless data storage decrypto:wrap {remaining:""} run function decrypto:title/wrap/scan
