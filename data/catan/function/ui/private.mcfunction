data modify storage catan:ui hand set value {resources:[0,0,0,0,0],dev:[0,0,0,0,0],fresh:[0,0,0,0,0],vp:0,roads_left:15,settlements_left:5,cities_left:4,discard_due:0}
$data modify storage catan:ui hand merge from entity @e[tag=ca.current,limit=1] data.catan.p$(side)
$data modify storage catan:ui hand.side set value $(side)
$data modify storage catan:ui hand.color_label set value "$(color_label)"
data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank
data modify storage catan:ui hand.r0 set from storage catan:ui hand.resources[0]
data modify storage catan:ui hand.r1 set from storage catan:ui hand.resources[1]
data modify storage catan:ui hand.r2 set from storage catan:ui hand.resources[2]
data modify storage catan:ui hand.r3 set from storage catan:ui hand.resources[3]
data modify storage catan:ui hand.r4 set from storage catan:ui hand.resources[4]
function catan:ui/hand_summary with storage catan:ui hand
