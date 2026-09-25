data modify storage decrypto:wrap character set string storage decrypto:wrap remaining 0 1
data modify storage decrypto:wrap remaining set string storage decrypto:wrap remaining 1
# 书中换行在面板上视为空格；只有达到36字符时才换行，原文记录保持不变。
execute if data storage decrypto:wrap {character:"\n"} run data modify storage decrypto:wrap character set value " "
execute unless data storage decrypto:wrap {character:"\r"} run function decrypto:title/wrap/character
execute unless data storage decrypto:wrap {remaining:""} run function decrypto:title/wrap/scan
