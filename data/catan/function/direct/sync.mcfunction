function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct side int 1 run scoreboard players get @s ca_side
execute store result storage catan:direct epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/read_hand with storage catan:direct
execute store result score #controls ca_ctx run clear @s *[minecraft:custom_data~{catan:{control:1b}}] 0
execute unless score #controls ca_ctx matches 9 run scoreboard players set @s ca_confirm -999
execute unless score #controls ca_ctx matches 9 run scoreboard players set @s ca_depoch -1
execute unless score @s ca_depoch = @e[tag=ca.current,limit=1] ca_epoch run function catan:direct/rebuild
function catan:direct/resources
function catan:direct/development
