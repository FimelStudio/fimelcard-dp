# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/open
data modify storage catan:ui trade set from entity @e[tag=ca.current,limit=1] data.catan.trade
function catan:ui/trade_guard with storage catan:ui trade
