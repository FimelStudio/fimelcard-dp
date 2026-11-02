# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui hand set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)
data modify storage splendor:ui hand.reserve_count set value 0
execute store result storage splendor:ui hand.reserve_count int 1 run data get storage splendor:ui hand.reserve
data modify storage splendor:ui hand.t0 set from storage splendor:ui hand.tokens[0]
data modify storage splendor:ui hand.t1 set from storage splendor:ui hand.tokens[1]
data modify storage splendor:ui hand.t2 set from storage splendor:ui hand.tokens[2]
data modify storage splendor:ui hand.t3 set from storage splendor:ui hand.tokens[3]
data modify storage splendor:ui hand.t4 set from storage splendor:ui hand.tokens[4]
data modify storage splendor:ui hand.t5 set from storage splendor:ui hand.tokens[5]
data modify storage splendor:ui hand.b0 set from storage splendor:ui hand.bonus[0]
data modify storage splendor:ui hand.b1 set from storage splendor:ui hand.bonus[1]
data modify storage splendor:ui hand.b2 set from storage splendor:ui hand.bonus[2]
data modify storage splendor:ui hand.b3 set from storage splendor:ui hand.bonus[3]
data modify storage splendor:ui hand.b4 set from storage splendor:ui hand.bonus[4]
function splendor:ui/private_show with storage splendor:ui hand
