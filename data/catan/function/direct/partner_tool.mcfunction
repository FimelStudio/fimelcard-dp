$execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score @e[tag=ca.current,limit=1] ca_turn matches $(side) run return 0
$data modify storage catan:direct partner set from entity @e[tag=ca.current,limit=1] data.catan.p$(side)
$data modify storage catan:direct partner.side set value $(side)
execute store result storage catan:direct partner.table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct partner.epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/partner_item with storage catan:direct partner
