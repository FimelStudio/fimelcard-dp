$data modify storage catan:direct victim set from entity @e[tag=ca.current,limit=1] data.catan.p$(side)
$data modify storage catan:direct victim.side set value $(side)
execute store result storage catan:direct victim.table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct victim.epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/victim_item with storage catan:direct victim
