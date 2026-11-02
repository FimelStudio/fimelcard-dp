$data modify storage catan:visual owner set from entity @s data.catan.vertex_owner[$(target)]
execute if data storage catan:visual {owner:0} run return 0
$data modify storage catan:visual level set from entity @s data.catan.vertex_level[$(target)]
execute if data storage catan:visual {level:0} run return 0
$data modify storage catan:visual target set value $(target)
$data modify storage catan:visual id set value $(target)
data modify storage catan:visual collection set value "vertices"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual pose.qy set from storage catan:visual geom.qy
data modify storage catan:visual pose.qw set from storage catan:visual geom.qw
function catan:visual/owner_color
function catan:visual/building_model with storage catan:visual
data modify storage catan:visual kind set value 6
function catan:visual/spawn
