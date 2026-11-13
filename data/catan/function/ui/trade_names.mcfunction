# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui trade.from_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(from).name
$data modify storage catan:ui trade.to_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(to).name
$scoreboard players set #ui_trade_to ca_ctx $(to)
