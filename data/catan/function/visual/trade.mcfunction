data modify storage catan:visual seat set value 0
data modify storage catan:visual seat set from storage catan:visual event.from_seat
function catan:visual/seat_coordinate with storage catan:visual
data modify storage catan:visual motion.from set value [0.0,0.24,0.0]
data modify storage catan:visual motion.from[0] set from storage catan:visual point.x
data modify storage catan:visual motion.from[2] set from storage catan:visual point.z
data modify storage catan:visual seat set value 0
data modify storage catan:visual seat set from storage catan:visual event.to_seat
function catan:visual/seat_coordinate with storage catan:visual
data modify storage catan:visual motion.to set from storage catan:visual point
data modify storage catan:visual model set value "bag"
function catan:visual/fx_spawn
data modify storage catan:visual swap set from storage catan:visual motion.from
data modify storage catan:visual motion.from[0] set from storage catan:visual motion.to.x
data modify storage catan:visual motion.from[2] set from storage catan:visual motion.to.z
data modify storage catan:visual motion.to.x set from storage catan:visual swap[0]
data modify storage catan:visual motion.to.z set from storage catan:visual swap[2]
function catan:visual/fx_spawn
