execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:direct/private
execute if data storage catan:ui hand{discard_due:0} run return run function catan:direct/no_discard
scoreboard players set @s ca_edit 1
execute store result storage catan:direct id int 1 run scoreboard players get #resource ca_ctx
function catan:direct/discard_one with storage catan:direct
