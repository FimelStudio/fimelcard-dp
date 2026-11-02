$data modify storage catan:visual target set value $(target)
$data modify storage catan:visual terrain set from entity @s data.catan.terrain[$(target)]
data modify storage catan:visual collection set value "hexes"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual pose.qy set from storage catan:visual geom.qy
data modify storage catan:visual pose.qw set from storage catan:visual geom.qw
data modify storage catan:visual kind set value 2
$data modify storage catan:visual id set value $(target)
execute if data storage catan:visual {terrain:0} run data modify storage catan:visual model set value "tile/forest"
execute if data storage catan:visual {terrain:1} run data modify storage catan:visual model set value "tile/hills"
execute if data storage catan:visual {terrain:2} run data modify storage catan:visual model set value "tile/pasture"
execute if data storage catan:visual {terrain:3} run data modify storage catan:visual model set value "tile/fields"
execute if data storage catan:visual {terrain:4} run data modify storage catan:visual model set value "tile/mountains"
execute if data storage catan:visual {terrain:5} run data modify storage catan:visual model set value "tile/desert"
function catan:visual/spawn
$data modify storage catan:visual number set from entity @s data.catan.numbers[$(target)]
execute if data storage catan:visual {number:0} run return 0
function catan:visual/number with storage catan:visual
