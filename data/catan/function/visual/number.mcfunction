$data modify storage catan:visual model set value "number/$(number)"
data modify storage catan:visual kind set value 3
data modify storage catan:visual pose.scale set from storage catan:visual geom.token_scale
data modify storage catan:visual pose.y set value 0.065
function catan:visual/label_spawn
