# 保存完整原文，并为新增提示建立36字符换行缓存。
data modify storage decrypto:input name set from storage decrypto:round black.1
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_b1
data modify storage decrypto:wrap args.side set value "white"
function decrypto:notes/record with storage decrypto:wrap args
data modify storage decrypto:input name set from storage decrypto:round black.2
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_b2
data modify storage decrypto:wrap args.side set value "white"
function decrypto:notes/record with storage decrypto:wrap args
data modify storage decrypto:input name set from storage decrypto:round black.3
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_b3
data modify storage decrypto:wrap args.side set value "white"
function decrypto:notes/record with storage decrypto:wrap args
