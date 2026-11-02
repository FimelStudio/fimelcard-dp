data modify storage catan:visual target set from entity @s data.catan.robber
data modify storage catan:visual collection set value "hexes"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale
function catan:visual/piece_y
data modify storage catan:visual model set value "robber"
data modify storage catan:visual kind set value 7
data modify storage catan:visual id set value 0
function catan:visual/spawn
