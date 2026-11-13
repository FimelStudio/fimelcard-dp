function catan:direct/private
data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank
function catan:ui/bank_summary
execute store result storage catan:direct pay int 1 run scoreboard players get @s ca_pay
execute store result storage catan:direct receive int 1 run scoreboard players get @s ca_receive
execute if score @s ca_pay matches 0 run data modify storage catan:direct give_name set value "木材"
execute if score @s ca_pay matches 1 run data modify storage catan:direct give_name set value "砖块"
execute if score @s ca_pay matches 2 run data modify storage catan:direct give_name set value "羊毛"
execute if score @s ca_pay matches 3 run data modify storage catan:direct give_name set value "粮食"
execute if score @s ca_pay matches 4 run data modify storage catan:direct give_name set value "矿石"
execute if score @s ca_receive matches 0 run data modify storage catan:direct get_name set value "木材"
execute if score @s ca_receive matches 1 run data modify storage catan:direct get_name set value "砖块"
execute if score @s ca_receive matches 2 run data modify storage catan:direct get_name set value "羊毛"
execute if score @s ca_receive matches 3 run data modify storage catan:direct get_name set value "粮食"
execute if score @s ca_receive matches 4 run data modify storage catan:direct get_name set value "矿石"
