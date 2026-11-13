$data modify storage catan:direct ratio set from storage catan:ui ratio$(pay)
execute if score @s ca_pay matches 0 run data modify storage catan:direct give_name set value "木材"
execute if score @s ca_receive matches 0 run data modify storage catan:direct get_name set value "木材"
execute if score @s ca_pay matches 1 run data modify storage catan:direct give_name set value "砖块"
execute if score @s ca_receive matches 1 run data modify storage catan:direct get_name set value "砖块"
execute if score @s ca_pay matches 2 run data modify storage catan:direct give_name set value "羊毛"
execute if score @s ca_receive matches 2 run data modify storage catan:direct get_name set value "羊毛"
execute if score @s ca_pay matches 3 run data modify storage catan:direct give_name set value "粮食"
execute if score @s ca_receive matches 3 run data modify storage catan:direct get_name set value "粮食"
execute if score @s ca_pay matches 4 run data modify storage catan:direct give_name set value "矿石"
execute if score @s ca_receive matches 4 run data modify storage catan:direct get_name set value "矿石"
function catan:direct/bank_note with storage catan:direct
