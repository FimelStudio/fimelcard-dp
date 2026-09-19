# 保存到当前牌桌控制器；仅将动态索引用于宏，不把词语拼入命令。
data modify entity @s data.decrypto.keywords set value {}
data modify entity @s data.decrypto.keywords.white set value {"text":"","extra":[{"text":"1 "},{"text":""},{"text":"　2 "},{"text":""},{"text":"　3 "},{"text":""},{"text":"　4 "},{"text":""}]}
data modify entity @s data.decrypto.keywords.white.extra[1].text set from storage decrypto:words selected[0]
data modify entity @s data.decrypto.keywords.white.extra[3].text set from storage decrypto:words selected[1]
data modify entity @s data.decrypto.keywords.white.extra[5].text set from storage decrypto:words selected[2]
data modify entity @s data.decrypto.keywords.white.extra[7].text set from storage decrypto:words selected[3]
data modify entity @s data.decrypto.keywords.black set value {"text":"","extra":[{"text":"1 "},{"text":""},{"text":"　2 "},{"text":""},{"text":"　3 "},{"text":""},{"text":"　4 "},{"text":""}]}
data modify entity @s data.decrypto.keywords.black.extra[1].text set from storage decrypto:words selected[4]
data modify entity @s data.decrypto.keywords.black.extra[3].text set from storage decrypto:words selected[5]
data modify entity @s data.decrypto.keywords.black.extra[5].text set from storage decrypto:words selected[6]
data modify entity @s data.decrypto.keywords.black.extra[7].text set from storage decrypto:words selected[7]
