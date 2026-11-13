$data modify storage catan:visual target set value $(target)
$data modify storage catan:visual port set from entity @s data.catan.port_types[$(target)]
$data modify storage catan:visual id set value $(target)
function catan:visual/port_at with storage catan:visual
