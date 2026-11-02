$data modify storage catan:visual owner set from entity @s data.catan.road_owner[$(target)]
execute if data storage catan:visual {owner:0} run return 0
$data modify storage catan:visual target set value $(target)
$data modify storage catan:visual id set value $(target)
data modify storage catan:visual collection set value "edges"
function catan:visual/coordinate with storage catan:visual
function catan:visual/owner_color
function catan:visual/road_model with storage catan:visual
data modify storage catan:visual kind set value 5
function catan:visual/spawn
