# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# p 是复合标签，宏将其序列化为SNBT；玩家文字不直接拼接成函数命令。
$data modify storage decrypto:form incoming set value $(p)
function decrypto:prompt/receive
