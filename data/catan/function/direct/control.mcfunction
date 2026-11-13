$execute if items entity @s hotbar.$(slot) * unless items entity @s hotbar.$(slot) *[minecraft:custom_data~{catan:{tool:1b}}] run return run function catan:direct/space
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
$data modify storage catan:direct control set value {slot:$(slot),action:$(action),label:"$(label)",model:"$(model)"}
data modify storage catan:direct control.table set from storage catan:direct table
data modify storage catan:direct control.epoch set from storage catan:direct epoch
function catan:direct/control_item with storage catan:direct control
