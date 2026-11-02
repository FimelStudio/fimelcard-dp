# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui person set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)
data modify storage splendor:ui person.reserve_count set value 0
execute store result storage splendor:ui person.reserve_count int 1 run data get storage splendor:ui person.reserve
data modify storage splendor:ui person.t0 set from storage splendor:ui person.tokens[0]
data modify storage splendor:ui person.t1 set from storage splendor:ui person.tokens[1]
data modify storage splendor:ui person.t2 set from storage splendor:ui person.tokens[2]
data modify storage splendor:ui person.t3 set from storage splendor:ui person.tokens[3]
data modify storage splendor:ui person.t4 set from storage splendor:ui person.tokens[4]
data modify storage splendor:ui person.t5 set from storage splendor:ui person.tokens[5]
data modify storage splendor:ui person.b0 set from storage splendor:ui person.bonus[0]
data modify storage splendor:ui person.b1 set from storage splendor:ui person.bonus[1]
data modify storage splendor:ui person.b2 set from storage splendor:ui person.bonus[2]
data modify storage splendor:ui person.b3 set from storage splendor:ui person.bonus[3]
data modify storage splendor:ui person.b4 set from storage splendor:ui person.bonus[4]
function splendor:ui/public_append with storage splendor:ui person
