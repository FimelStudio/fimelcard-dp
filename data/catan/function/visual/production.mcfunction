function catan:visual/seat
data modify storage catan:visual motion.to set from storage catan:visual point
data modify storage catan:visual target set from storage catan:visual event.target
data modify storage catan:visual collection set value "hexes"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual motion.from set value [0.0,0.12,0.0]
data modify storage catan:visual motion.from[0] set from storage catan:visual pose.x
data modify storage catan:visual motion.from[2] set from storage catan:visual pose.z
execute if data storage catan:visual event{resource:0} run data modify storage catan:visual model set value "resource/wood"
execute if data storage catan:visual event{resource:1} run data modify storage catan:visual model set value "resource/brick"
execute if data storage catan:visual event{resource:2} run data modify storage catan:visual model set value "resource/wool"
execute if data storage catan:visual event{resource:3} run data modify storage catan:visual model set value "resource/grain"
execute if data storage catan:visual event{resource:4} run data modify storage catan:visual model set value "resource/ore"
function catan:visual/fx_spawn
