$data modify storage catan:ui person set from entity @s data.catan.p$(side)
$data modify storage catan:ui person.side set value $(side)
$data modify storage catan:ui person.color_label set value "$(label)"
$data modify storage catan:ui person.color set value "$(color)"
function catan:ui/public_append with storage catan:ui person
