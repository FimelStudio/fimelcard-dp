data modify storage catan:visual frame set value 0
data modify storage catan:visual roll set value 1
data modify storage catan:visual die set value 1
data modify storage catan:visual roll set from entity @s data.catan.dice[0]
function catan:visual/dice_apply
data modify storage catan:visual roll set value 1
data modify storage catan:visual die set value 2
data modify storage catan:visual roll set from entity @s data.catan.dice[1]
function catan:visual/dice_apply
