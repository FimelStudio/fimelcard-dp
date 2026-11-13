execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:direct/private
execute if data storage catan:ui hand{discard_due:0} run return 0
execute unless score @s ca_dphase matches 1 run function catan:direct/discard_reset
scoreboard players set @s ca_dphase 1
scoreboard players set @s ca_edit 1
