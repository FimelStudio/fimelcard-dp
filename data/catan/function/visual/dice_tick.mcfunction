execute store result storage catan:visual frame int 1 run scoreboard players get @s ca_vtimer
data modify storage catan:visual die set value 1
data modify storage catan:visual roll set from entity @s data.catan.visual_active.die1
function catan:visual/dice_apply
data modify storage catan:visual die set value 2
data modify storage catan:visual roll set from entity @s data.catan.visual_active.die2
function catan:visual/dice_apply
