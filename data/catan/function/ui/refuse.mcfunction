function catan:ui/prepare
data modify storage catan:action input.code set value 42
execute store result storage catan:action input.target int 1 run scoreboard players get @s ca_trade_id
function catan:ui/submit
