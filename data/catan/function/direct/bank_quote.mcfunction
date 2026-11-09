execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:direct/private
data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank
function catan:ui/bank_summary
execute store result storage catan:direct pay int 1 run scoreboard players get @s ca_pay
execute store result storage catan:direct receive int 1 run scoreboard players get @s ca_receive
function catan:direct/bank_names with storage catan:direct
