# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:ui bank.t0 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[0]
data modify storage splendor:ui bank.t1 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[1]
data modify storage splendor:ui bank.t2 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[2]
data modify storage splendor:ui bank.t3 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[3]
data modify storage splendor:ui bank.t4 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[4]
data modify storage splendor:ui bank.t5 set from entity @e[tag=sp.current,limit=1] data.splendor.bank[5]
function splendor:ui/bank_append with storage splendor:ui bank
