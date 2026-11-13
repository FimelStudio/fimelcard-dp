# 保存完整原文，并为新增提示建立36字符换行缓存。
data modify storage decrypto:input name set from storage decrypto:round white.1
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_w1
data modify storage decrypto:wrap args.side set value "black"
function decrypto:notes/record with storage decrypto:wrap args
data modify storage decrypto:input name set from storage decrypto:round white.2
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_w2
data modify storage decrypto:wrap args.side set value "black"
function decrypto:notes/record with storage decrypto:wrap args
data modify storage decrypto:input name set from storage decrypto:round white.3
execute store result storage decrypto:wrap args.digit int 1 run scoreboard players get @s dc_w3
data modify storage decrypto:wrap args.side set value "black"
function decrypto:notes/record with storage decrypto:wrap args

execute store result storage decrypto:sync digit int 1 run scoreboard players get @s dc_w1
data modify storage decrypto:sync side set value "white"
data modify storage decrypto:sync clue set from storage decrypto:round white.1
function decrypto:sync/archive with storage decrypto:sync

execute store result storage decrypto:sync digit int 1 run scoreboard players get @s dc_w2
data modify storage decrypto:sync side set value "white"
data modify storage decrypto:sync clue set from storage decrypto:round white.2
function decrypto:sync/archive with storage decrypto:sync

execute store result storage decrypto:sync digit int 1 run scoreboard players get @s dc_w3
data modify storage decrypto:sync side set value "white"
data modify storage decrypto:sync clue set from storage decrypto:round white.3
function decrypto:sync/archive with storage decrypto:sync
